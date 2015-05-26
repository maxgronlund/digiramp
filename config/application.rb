require File.expand_path('../boot', __FILE__)

require 'csv'
require 'rails/all'
require "awesome_print"
require 'charlock_holmes'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Digiramp
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    
    #config.generators do |g|
    #      g.test_framework  :rspec
    #      g.integration_tool :rspec
    #end
    
    #config.exceptions_app = self.routes
    
    
    config.action_dispatch.default_headers = {
        'X-Frame-Options' => 'ALLOWALL'
    }
    config.autoload_paths += %W(#{config.root}/app/workers)
    
    Koala.config.api_version = 'v2.2'
    
    # prepare for rails 5
    config.active_record.raise_in_transactional_callbacks = true
    
    # new rails 4.2 abstraction layer for background jobs
    config.active_job.queue_adapter = :sidekiq
    #ActiveJob::Base.queue_adapter = :sidekiq
    #config.active_job.queue_adapter = :sidekiq
    

  end
end


