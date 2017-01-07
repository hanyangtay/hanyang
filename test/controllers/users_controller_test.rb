require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup 
    @user = users(:Han)
    @other_user = users(:Fritz)
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "redirect update when not logged in" do
    patch user_path(@user), params: { user: {name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "redirect edit when wrongUser" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "redirect update when wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: {name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end
  
  test "admin not changeable" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: { user: { password: "abcdef1!",
                                            password_confirmation: "abcdef1!",
                                            admin: true } }
    assert_not @other_user.reload.admin?
  end
  
  test "redirect destroy when not logged in" do
    get users_path
    assert_redirected_to login_url
  end
  
  test "redirect destroy when not admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end
  
  test "redirect following when not logged in" do
    get followers_user_path(@user)
    assert_redirected_to login_url
  end
  
  test "redirect followers when not logged in" do
    get followers_user_path(@user)
    assert_redirected_to login_url
  end
  
end
