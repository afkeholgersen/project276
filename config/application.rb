require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Project276
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    ENV['APP_ID'] = "3096f3a5"
    ENV['APP_KEY'] = "889c5a8d00ada6f56ebc32e860f65978"
    ENV['API_URL'] = "https://api.edamam.com"
  end
end
