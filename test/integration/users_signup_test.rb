require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  def setup
    ActionMailer::Base.deliveries.clear
  end
  
  test "invalidSignup" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                        email: "user@invalid",
                        password: "foobar123",
                        password_confirmation: "foobar123"
      } }
    end
    assert_template 'users/new'
  end
  
  test "validSignup" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: "Zephyr",
                          email: "zephyr@zephyr.com",
                          password: "Abcdefg1!",
                          password_confirmation: "Abcdefg1!" 
      } }
      end
    
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    log_in_as(user)
    assert_not is_logged_in?
    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?
    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
  
end
