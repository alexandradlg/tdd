class UsersControllerTest < ActionDispatch::IntegrationTest

    test "should show user profile" do
        @user = users(:one)
        sign_in(@user)
        current_user = @user
        get user_url(@user)
        assert_response :success
        assert_select 'p', "First name : #{@user.first_name}"
        assert_select 'p', "Last name : #{@user.last_name}"
        assert_select 'p', "Email : #{@user.email}"
        assert_select 'p', "Editer"
      end

      test "show shouldn't link to edit" do
        @user = users(:one)
        sign_in(@user)
        get user_url(@user)
        assert_select 'p', "First name : #{@user.first_name}"
        assert_select 'p', "Last name : #{@user.last_name}"
        assert_select 'p', "Email : #{@user.email}"
      end

      test "show should link to edit" do
        @user = users(:one)
        sign_in(@user)
        current_user = @user
        get user_url(@user)
        assert_response :success
        assert_select 'a[href=?]', edit_user_registration_path
      end

      test "invalid edit information " do
        @user = users(:one)
        sign_in(@user)
        current_user = @user
        get edit_user_registration_path
          put user_registration_path, params: { user: { email: "user@test.com",
                                               first_name:  "User",
                                               last_name: "test",
                                               password: "newpassword",
                                               password_confirmation: "password",                                  
                                               current_password: "password" } }
        assert_response :success
        assert_select 'div#error_explanation'
      end

      test "should show user edit" do
        @user = users(:one)
        sign_in(@user)
        current_user = @user
        get edit_user_registration_url(@user)
        assert_response :success
        assert_select 'h2', "Edit User"
      end


      test "shouldn't show user edit" do
        @user = users(:one)
        get edit_user_registration_url(@user)
        assert_response 401
      end
    
end