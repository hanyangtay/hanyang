require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
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
    follow_redirect!
    assert_template 'users/show'
  end
  
end
