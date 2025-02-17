require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get play" do
    get pages_play_url
    assert_response :success
  end

  test "should get moments" do
    get pages_moments_url
    assert_response :success
  end
end
