module ResponseBuilder
  
  def self.json_builder(json, status, msg, *args)
    options            = args.last.is_a?(Hash) ? args.pop : {}
    info               = ActiveSupport::OrderedHash.new
    info[:resp_status] = status
    info[:message]     = msg
    info[:errors]      = options[:errors]
    info[:paging_data] = options[:paging_data]
    
    unless json.to_s == "" || json.blank?
      data = { data: json }
      hash = info.merge(data)
    else
      data = { data: {} }.to_hash
      hash = info.merge(data)
    end
    
    puts hash.as_json
    return hash.as_json
  end
  
  def xml_builder(xml, status, msg, *args)
    options = args.last.is_a?(Hash) ? args.pop : {}
    
    info                  = ActiveSupport::OrderedHash.new
    info[:resp_status]    = status
    info[:message]        = msg
    info[:gateway_status] = options[:gateway_status]
    info[:errors]         = options[:errors]
    info[:paging_data]    = options[:paging_data]
    
    if session[:is_setting_websites_required]
      info[:settings] = setting_websites
    end
    
    unless (xml.to_s == "")
      data = { :data => Hash.from_xml(xml) }.to_hash
      hash = info.merge(data)
    else
      unless options[:tag_name].blank?
        data = { :data => { options[:tag_name] => "" } }.to_hash
      else
        data = { :data => "" }.to_hash
      end
      hash = info.merge(data)
    end
    return hash.to_xml(:skip_instruct => true, :skip_types => true, :dasherize => false)
  end
  
  def self.get_paging_data(page, per_page, records)
    page < records.total_pages ? next_page_exist = true : next_page_exist = false
    page > 1 && page <= records.total_pages ? previous_page_exist = true : previous_page_exist = false
    {
        page:                page,
        per_page:            per_page,
        total_records:       records.total_entries,
        total_pages:         records.total_pages,
        next_page_exist:     next_page_exist,
        previous_page_exist: previous_page_exist
      
    }
  end

end