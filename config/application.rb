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
    ENV['APP_ID'] = "02096b9c"
    ENV['APP_KEY'] = "3f42c3f48deb709909715e3fb7e94bbe"
    ENV['API_URL'] = "https://api.edamam.com"
    
    ENV['MAILGUN_SMTP_PORT'] = "587"
    ENV['MAILGUN_SMTP_SERVER'] = "ENTER SMTP SERVER"
    ENV['MAILGUN_SMTP_LOGIN'] = "ENTER LOGIN"
    ENV['MAILGUN_SMTP_PASSWORD'] = "ENTER PASSWORD"
  
  end
end
