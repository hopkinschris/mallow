Airbrake.configure do |config|
  config.api_key = ENV['AIRBRAKE_API_KEY']
  
  # Report exceptions that happen inside a rake task
  config.rescue_rake_exceptions = true
end
