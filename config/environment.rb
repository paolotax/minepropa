# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Minepropa::Application.initialize!

Money.default_currency = Money::Currency.new("EUR")