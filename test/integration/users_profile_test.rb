require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:Han)
  end
  
  test "profile" do
    get user_path(@user)
    assert_template "users/show"
    assert_match @user.status_posts.count.to_s, response.body
    assert_select 'nav.pagination'
  end
end
