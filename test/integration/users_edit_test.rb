require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:Han)
  end
  
  test "unsuccessfulEdit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }
    assert_template 'users/edit'
    assert_not flash.empty?
  end
  
  test "successfulEdit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Fritz Tay"
    email = "german@wesleyan.edu"
    patch user_path(@user), params: { user: { name: name, email: email,
                                              password: "",
                                              password_confirmation: ""} }
    assert_not flash.empty?
    assert_redirected_to edit_user_path(@user)
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
  
  test "successfulEditwithFriendlyForwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    assert_nil session[:fowarding_url]
    name = "Fritz Tay"
    email = "german@wesleyan.edu"
    patch user_path(@user), params: { user: { name: name, email: email,
                                              password: "",
                                              password_confirmation: ""} }
    assert_not flash.empty?
    assert_redirected_to edit_user_path(@user)
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
  
end
