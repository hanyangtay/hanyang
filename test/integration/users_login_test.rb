require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:Han)
  end
  
  test "invalidLogin" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  
  test "validLoginLogOut" do
    get login_path
    post login_path, params: { session: { email: @user.email,
                                          password: 'abcdef1!' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path, count: 2
    assert_select "a[href=?]", user_path(@user), count: 2
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    #simulate user logging out in a second window
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path, count: 2
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
  
  test "loginRemember" do
    log_in_as(@user, remember_me: '1')
    assert_equal cookies['remember_token'], assigns(:user).remember_token
  end
  
  test "loginNoRemember" do
    log_in_as(@user, remember_me: '1')
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end
end