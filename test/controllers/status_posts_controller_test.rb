require 'test_helper'

class StatusPostsControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @status_post = status_posts(:text_1)
  end
  
  test "redirect create when not logged in" do
    assert_no_difference 'StatusPost.count' do
      post status_posts_path, params: { status_post: 
                                          { content: "Lorem ipsum" } }
      end
    assert_redirected_to login_url
  end
  
  test "redirect destroy when not logged in" do
    assert_no_difference 'StatusPost.count' do
      delete status_post_path(@status_post)
    end
    assert_redirected_to login_url
  end
  
  test "redirect destroy for wrong status post" do
    log_in_as(users(:Han))
    status_post = status_posts(:text_5)
    assert_no_difference 'StatusPost.count' do
      delete status_post_path(status_post)
    end
    assert_redirected_to status_posts_url
  end

end