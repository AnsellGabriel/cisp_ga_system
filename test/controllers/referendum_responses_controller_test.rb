require "test_helper"

class ReferendumResponsesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @referendum_response = referendum_responses(:one)
  end

  test "should get index" do
    get referendum_responses_url
    assert_response :success
  end

  test "should get new" do
    get new_referendum_response_url
    assert_response :success
  end

  test "should create referendum_response" do
    assert_difference("ReferendumResponse.count") do
      post referendum_responses_url, params: { referendum_response: { event_hub_id: @referendum_response.event_hub_id, referendum_id: @referendum_response.referendum_id, response: @referendum_response.response } }
    end

    assert_redirected_to referendum_response_url(ReferendumResponse.last)
  end

  test "should show referendum_response" do
    get referendum_response_url(@referendum_response)
    assert_response :success
  end

  test "should get edit" do
    get edit_referendum_response_url(@referendum_response)
    assert_response :success
  end

  test "should update referendum_response" do
    patch referendum_response_url(@referendum_response), params: { referendum_response: { event_hub_id: @referendum_response.event_hub_id, referendum_id: @referendum_response.referendum_id, response: @referendum_response.response } }
    assert_redirected_to referendum_response_url(@referendum_response)
  end

  test "should destroy referendum_response" do
    assert_difference("ReferendumResponse.count", -1) do
      delete referendum_response_url(@referendum_response)
    end

    assert_redirected_to referendum_responses_url
  end
end
