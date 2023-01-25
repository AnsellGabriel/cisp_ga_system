require "test_helper"

class CoopEventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @coop_event = coop_events(:one)
  end

  test "should get index" do
    get coop_events_url
    assert_response :success
  end

  test "should get new" do
    get new_coop_event_url
    assert_response :success
  end

  test "should create coop_event" do
    assert_difference("CoopEvent.count") do
      post coop_events_url, params: { coop_event: { active: @coop_event.active, description: @coop_event.description, election: @coop_event.election, event_date: @coop_event.event_date, name: @coop_event.name } }
    end

    assert_redirected_to coop_event_url(CoopEvent.last)
  end

  test "should show coop_event" do
    get coop_event_url(@coop_event)
    assert_response :success
  end

  test "should get edit" do
    get edit_coop_event_url(@coop_event)
    assert_response :success
  end

  test "should update coop_event" do
    patch coop_event_url(@coop_event), params: { coop_event: { active: @coop_event.active, description: @coop_event.description, election: @coop_event.election, event_date: @coop_event.event_date, name: @coop_event.name } }
    assert_redirected_to coop_event_url(@coop_event)
  end

  test "should destroy coop_event" do
    assert_difference("CoopEvent.count", -1) do
      delete coop_event_url(@coop_event)
    end

    assert_redirected_to coop_events_url
  end
end
