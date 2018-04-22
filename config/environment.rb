# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Load the app's custom environment variables here, before environments/*.rb
app_env_variables = File.join(Rails.root, 'config', 'initializers', 'app_env_variables.rb')
load(app_env_variables) if File.exists?(app_env_variables)

# Initialize the Rails application.
Rails.application.initialize!
