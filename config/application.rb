# frozen_string_literal: true
require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
# require "active_model/railtie"
# require "active_job/railtie"
require 'active_record/railtie'
require 'action_controller/railtie'
require "action_mailer/railtie"
# require "action_view/railtie"
# require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Projects
  # :nodoc:
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    Dir["#{Rails.root}/lib/**/*.rb"].each { |f| require(f) }

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    Dir["#{Rails.root}/app/error_objects/*.rb"].each { |f| require(f) }
    Dir["#{Rails.root}/app/services/**/*.rb"].sort.each { |f| require(f) }

    config.api_only = true
  end
end
