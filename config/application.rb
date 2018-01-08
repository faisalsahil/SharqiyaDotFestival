require_relative 'boot'
require 'rack/cors'
require 'rails/all'
# require 'carrierwave/orm/activerecord'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SharqiyaDotFestival
  class Application < Rails::Application
    config.autoload_paths << "#{config.root}/lib"
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.action_controller.permit_all_parameters = true
    
  end
end
