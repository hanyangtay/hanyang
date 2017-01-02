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

  test "redirectEditwhenNotLoggedIn" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "redirectUpdatewhenNotLoggedIn" do
    patch user_path(@user), params: { user: {name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "redirectEditwhenWrongUser" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "redirectUpdatewhenWrongUser" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: {name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "redirectIndexwhenNotLoggedIn" do
    get users_path
    assert_redirected_to login_url
  end
  
  test "adminNotChangeable" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: { user: { password: "abcdef1!",
                                            password_confirmation: "abcdef1!",
                                            admin: true } }
    assert_not @other_user.reload.admin?
  end
  
  test "redirectDestroywhenNotLoggedIn" do
    get users_path
    assert_redirected_to login_url
  end
  
  test "redirectDestroywhenNotAdmin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end
  
end
