require 'test_helper'

class Public::GroupPostCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_group_post_comments_new_url
    assert_response :success
  end

end
