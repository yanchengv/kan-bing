require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Mimas
  class Application < Rails::Application
    config.to_prepare do
      # Load application's model / class decorators
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.time_zone = 'Beijing'
    config.active_record.default_timezone = :local
    config.encoding = 'utf-8'
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Enable the asset pipeline
    #config.assets.enabled = true
    #config.assets.paths << "#{Rails.root}/app/views/images"
    #config.assets.paths << "#{Rails.root}/app/views/uploads"
    config.assets.paths << "#{Rails.root}/app/assets/flash"

    # Version of your assets, change this if you want to expire all your assets
    #config.assets.version = '1.0'
    #config.assets.initialize_on_precompile = false
    #config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.yml').to_s]
    #config.i18n.default_locale = 'zh-CN'
    I18n.config.enforce_available_locales = true
    config.active_record.observers = :message_observer
    #config.active_record.whitelist_attributes = true
  end
end
