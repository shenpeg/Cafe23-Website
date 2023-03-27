require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Cafe23
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.

    # config.autoload_paths += Dir["#{config.root}/lib/**/"]  # include all subdirectories
    config.eager_load_paths += %W[#{config.root}/lib]
    config.eager_load_paths += %W[#{config.root}/lib/filters]
    config.eager_load_paths += %W[#{config.root}/lib/helpers]

    config.time_zone = 'Eastern Time (US & Canada)'
    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_attributes = false
  end
end
