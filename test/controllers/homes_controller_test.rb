require 'test_helper'

class HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get about" do
    get homes_about_url
    assert_response :success
  end

  test "should get beginner" do
    get homes_beginner_url
    assert_response :success
  end

  test "should get already_work" do
    get homes_already_work_url
    assert_response :success
  end

end
