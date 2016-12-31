require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @base_title = "hanyang"
  end
  
  test "should get root" do
    get root_path
    assert_response :success
    assert_select "title", "#{@base_title} | Home"
  end

  test "should get projects" do
    get projects_path
    assert_response :success
    assert_select "title", "#{@base_title} | Projects"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "#{@base_title} | About me"
  end

end
