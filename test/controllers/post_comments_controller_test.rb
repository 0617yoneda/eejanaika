require 'test_helper'

class PostCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get post_comments_destroy_url
    assert_response :success
  end
end
