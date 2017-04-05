require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module StaffTracker
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.action_dispatch
          .rescue_responses["Pundit::NotAuthorizedError"] = :forbidden

    require Rails.root.join('lib/custom_public_exceptions')
    config.exceptions_app = CustomPublicExceptions.new(Rails.public_path)
  end
end
