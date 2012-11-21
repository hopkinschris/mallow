Mallowapp::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Email will pop up in browser instead of being sent
  config.action_mailer.delivery_method = :letter_opener

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin


  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  #OAuth Twitter
  ENV['TWITTER_KEY'] = 'URyGU4NkbuKGPR4slrZpA'
  ENV['TWITTER_SECRET'] = 'dSYu2lZ4hbRTbxEIElaqiqfRxZvpfTVo5WByA8rqb4'
  ENV['TWITTER_OAUTH_TOKEN'] = '131216274-A9I2GxssX1IgGbB8ut00EdUTcMFmqrMMP4tpymkY'
  ENV['TWITTER_OAUTH_TOKEN_SECRET'] = '9i1zvexIMTmOLWlYtnj8OeSV8bo4qe9So9OkqYgWQ'

  #SendGrid
  ENV['SENDGRID_USERNAME'] = 'app9055058@heroku.com'
  ENV['SENDGRID_PASSWORD'] = 'mjtr67Nr'
  ENV['SENDGRID_DOMAIN'] = 'mallowapp.herokuapp.com'
  ENV['SENDGRID_ADDRESS'] = 'smtp.sendgrid.net'

end
