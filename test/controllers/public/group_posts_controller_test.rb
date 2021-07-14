require 'test_helper'

class Public::GroupPostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_group_posts_index_url
    assert_response :success
  end

  test "should get show" do
    get public_group_posts_show_url
    assert_response :success
  end

  test "should get new" do
    get public_group_posts_new_url
    assert_response :success
  end

end
