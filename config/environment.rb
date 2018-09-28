# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
Slim::Engine.set_options pretty: true, sort_attrs: false
