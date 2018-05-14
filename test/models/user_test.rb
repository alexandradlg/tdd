require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "should be created" do
    assert User.new(first_name: "Example", last_name: "User", email: "user@example.com", password: "password").save
  end

  test "first_name validation required should apply" do
    assert_not User.new(last_name: " User", email: "user@example.com", password: "password").save
  end

  test "first_name validation not blank should apply" do
    assert_not User.new(first_name: "   ", last_name: "User", email: "user@example.com", password: "password").save
  end

  test "email validation unique should apply" do
    assert User.new(first_name: "Example", last_name: "User", email: "user@example.com", password: "password").save
    assert_not User.new(first_name: "Example", last_name: "User", email: "user@example.com", password: "password").save
  end

end
