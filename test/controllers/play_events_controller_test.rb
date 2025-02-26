require "test_helper"

class PlayEventsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get play_events_index_url
    assert_response :success
  end

  test "should get show" do
    get play_events_show_url
    assert_response :success
  end

  test "should get new" do
    get play_events_new_url
    assert_response :success
  end

  test "should get create" do
    get play_events_create_url
    assert_response :success
  end

  test "should get edit" do
    get play_events_edit_url
    assert_response :success
  end

  test "should get update" do
    get play_events_update_url
    assert_response :success
  end

  test "should get destroy" do
    get play_events_destroy_url
    assert_response :success
  end

  test "should get join" do
    get play_events_join_url
    assert_response :success
  end
end
