require "test_helper"

class ElectPositionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @elect_position = elect_positions(:one)
  end

  test "should get index" do
    get elect_positions_url
    assert_response :success
  end

  test "should get new" do
    get new_elect_position_url
    assert_response :success
  end

  test "should create elect_position" do
    assert_difference("ElectPosition.count") do
      post elect_positions_url, params: { elect_position: { coop_event_id: @elect_position.coop_event_id, name: @elect_position.name, vacant: @elect_position.vacant } }
    end

    assert_redirected_to elect_position_url(ElectPosition.last)
  end

  test "should show elect_position" do
    get elect_position_url(@elect_position)
    assert_response :success
  end

  test "should get edit" do
    get edit_elect_position_url(@elect_position)
    assert_response :success
  end

  test "should update elect_position" do
    patch elect_position_url(@elect_position), params: { elect_position: { coop_event_id: @elect_position.coop_event_id, name: @elect_position.name, vacant: @elect_position.vacant } }
    assert_redirected_to elect_position_url(@elect_position)
  end

  test "should destroy elect_position" do
    assert_difference("ElectPosition.count", -1) do
      delete elect_position_url(@elect_position)
    end

    assert_redirected_to elect_positions_url
  end
end
