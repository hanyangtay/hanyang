require 'test_helper'

class StatusPostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:Han)
    @status_post = @user.status_posts.build(content: "Lorem ipsum", user_id: @user.id )
  end
  
  test "isValid" do
    assert @status_post.valid?
  end
  
  test "user_id should be present" do
    @status_post.user_id = nil
    assert_not @status_post.valid?
  end
    
  test "content should be present" do
    @status_post.content = "  "
    assert_not @status_post.valid?
    @status_post.content = ""
    assert_not @status_post.valid?
  end
  
  test "contentLength should be less than 141" do
    @status_post.content = "a" * 141
    assert_not @status_post.valid?
  end
  
   test "order should be most recent first" do
    assert_equal status_posts(:most_recent), StatusPost.first
  end
  
end
