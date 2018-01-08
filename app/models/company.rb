class Company < ApplicationRecord
  include ResponseBuilder
  
  has_many :company_addresses
  has_many :company_galleries
  
  accepts_nested_attributes_for :company_addresses, :company_galleries, allow_destroy: true
  
  mount_uploader :company_logo, ImageUploader
  
  validates :company_name, presence: true
  
  scope :active, -> { where(is_active: true) }
  
  def self.api_company_listing(data)
    begin
      per_page = (data[:per_page] || 20).to_i
      page     = (data[:page] || 1).to_i
      
      companies = Company.all
      companies = companies.page(page.to_i).per_page(per_page.to_i)
      
      paging_data = ResponseBuilder.get_paging_data(page, per_page, companies)
      companies   = companies.as_json(
          only: [:id, :company_name, :company_logo, :short_description, :is_seen]
      )
      
      resp_data    = { companies: companies }.as_json
      resp_status  = 1
      resp_message = 'Companies List'
      resp_errors  = ''
    rescue Exception => e
      resp_data    = {}
      resp_status  = 0
      paging_data  = ''
      resp_message = 'error'
      resp_errors  = e
    end
    ResponseBuilder.json_builder(resp_data, resp_status, resp_message, errors: resp_errors, paging_data: paging_data)
  end
  
  def self.api_company_details(data)
    begin
      company = Company.where(id: data[:id])
      if company.present?
        
        company = company.as_json(
            only: [:id, :company_name, :company_logo, :short_description, :is_seen],
            include:{
                company_addresses: {
                    only: [:id, :street, :cit, :state, :zip]
                }
            }
        )
        
        resp_data    = { companies: company }.as_json
        resp_status  = 1
        resp_message = 'Companies Details'
        resp_errors  = ''
      else
        resp_data    = {}
        resp_status  = 1
        resp_message = 'No company found.'
        resp_errors  = ''
      end
    rescue Exception => e
      resp_data    = {}
      resp_status  = 0
      resp_message = 'error'
      resp_errors  = e
    end
    ResponseBuilder.json_builder(resp_data, resp_status, resp_message, errors: resp_errors)
  end
end
