require 'test_helper'

class Public::InquiriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_inquiries_index_url
    assert_response :success
  end

  test "should get confirm" do
    get public_inquiries_confirm_url
    assert_response :success
  end

  test "should get thanks" do
    get public_inquiries_thanks_url
    assert_response :success
  end

end
