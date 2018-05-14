ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/minitest'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.


  # Add more helper methods to be used by all tests here...
end

 
class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  fixtures :all
  include Capybara

end
