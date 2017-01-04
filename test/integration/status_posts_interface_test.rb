require 'test_helper'

class StatusPostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:Han)
  end
  
  test "status_post interface" do
    log_in_as(@user)
    get user_path(@user)
    assert_select 'input[type=file]'
    assert_no_difference 'StatusPost.count' do
      post status_posts_path, params: { status_post: { content: ""} }
    end
    assert_not flash.empty?
    content = "Hey"
    picture = fixture_file_upload('test/fixtures/hy.png', 'image/png')
    assert_difference 'StatusPost.count', 1 do
      post status_posts_path, params: { status_post: { content: content, 
                                                        picture: picture
      } }
    end
    assert @user.status_posts.first.picture?
    assert_redirected_to status_posts_path
    follow_redirect!
    assert_match content, response.body
    assert_select 'button', text: 'delete'
    first_status_post = @user.status_posts.page(1).first
    assert_difference 'StatusPost.count', -1 do
      delete status_post_path(first_status_post)
    end
    get user_path(users(:Fritz))
    assert_select 'button', text: 'delete', count: 0
  end
end
