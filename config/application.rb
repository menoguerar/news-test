require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module NewsletterApi
  class Application < Rails::Application
    config.assets.enabled = false
    config.generators do |g|
      g.test_framework :rspec, fixture: true
      g.view_specs false
      g.helper_specs false
    end

    # Validates the supplied and returned schema.
    # docs: https://github.com/interagent/committee
    config.middleware.use Committee::Middleware::RequestValidation, schema: JSON.parse(File.read("./schema/api.json")) if File.exist?("./schema/api.json")
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
