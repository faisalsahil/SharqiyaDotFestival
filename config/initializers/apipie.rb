Apipie.configure do |config|
  config.app_name                = "SharqiyaDotFestival"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apipie"

  config.languages               = ['en']
  config.default_locale          = 'en'

  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  # config.translate = false
end
