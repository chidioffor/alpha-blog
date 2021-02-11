require 'test_helper'

class SignupUserTest < ActionDispatch::IntegrationTest
  test "get new user form and create new user" do
    get signup_path    
    assert_response :success
    assert_difference('User.count', 1) do
      post users_path, params: { user: { username: "test890", password: "password",
                                email: "test890@example.com" } }
      assert_response :redirect
    end
    follow_redirect! 
    assert_response :redirect
    assert_redirected_to articles_path
  end

end
