require 'test_helper'

class IndexControllerTest < ActionDispatch::IntegrationTest

  test "home should get to the club" do
    sign_in(users(:one))
    get root_url
    assert_response :success
    assert_select 'a[href=?]', club_path
  end

  test "home should get to sign/signup" do
    get root_url
    assert_response :success
    assert_select 'a[href=?]', new_user_registration_path
    assert_select 'a[href=?]', new_user_session_path
  end

  test "invalid confirmation password signup information" do
    get new_user_registration_path
      post user_registration_path, params: { user: { email: "user@test.com",
                                           first_name:  "User",
                                           last_name: "test",                                  
                                           password: "password",
                                           password_confirmation: "blablabla", 
                                           commit: "Sign up"} }
    assert_response :success
    assert_select 'div#error_explanation'
  end

  test "invalid signup information first_name empty" do
    get new_user_registration_path
      post user_registration_path, params: { user: { email: "user@test.com",
                                           first_name:  "",
                                           last_name: "test",                                  
                                           password: "password",
                                           password_confirmation: "password" } }
    assert_response :success
    assert_select 'div#error_explanation'
  end

  test "valid signup information" do
    get new_user_registration_path
    assert_difference 'User.count', 1 do
      post user_registration_path, params: { user: { email: "user@test.com",
                                         first_name:  "User",
                                         last_name: "test",                                  
                                         password: "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!                                     
    assert_select 'a[href=?]', club_path
    assert_response :success
  end

  test "login with invalid information wrong email" do
    get new_user_session_path
    assert_template 'sessions/new'
    post user_session_path, params: { session: { email: "usertest.com",                                 
      password: "password",
      remember_me: "0" } }    
    assert_response :success
    assert_select 'div.alert.alert-alert'
  end

  # test "login with valid information" do
  #   @user = users(:michael)
  #   get new_user_session_path  
  #   post user_session_path, params: { session: { email:    @user.email,
  #     password: 'password',
  #     remember_me: "0"  } }
  #   follow_redirect!                   
  #   assert_select 'a[href=?]', club_path
  #   assert_response :success
  # end


  test "should show club" do
    sign_in(users(:one))
    get club_url
    assert_response :success
    assert_select 'div.container'
    assert_select 'th', "First name"
    assert_select 'th', "Last name"
    assert_select 'th', "Email"
  end

  test "shouldn't show club" do
    get new_user_session_url
    assert_response :success
  end
end