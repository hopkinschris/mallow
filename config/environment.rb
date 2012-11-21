# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Mallowapp::Application.initialize!

# Specify ActionMailer defaults
ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SENDGRID_USERNAME'],
  :password => ENV['SENDGRID_PASSWORD'],
  :domain => ENV['SENDGRID_DOMAIN'],
  :address => ENV['SENDGRID_ADDRESS'],
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
