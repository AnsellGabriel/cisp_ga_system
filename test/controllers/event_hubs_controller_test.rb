require "test_helper"

class EventHubsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event_hub = event_hubs(:one)
  end

  test "should get index" do
    get event_hubs_url
    assert_response :success
  end

  test "should get new" do
    get new_event_hub_url
    assert_response :success
  end

  test "should create event_hub" do
    assert_difference("EventHub.count") do
      post event_hubs_url, params: { event_hub: { capital: @event_hub.capital, coop_event_id: @event_hub.coop_event_id, cooperative_id: @event_hub.cooperative_id, vote_code: @event_hub.vote_code, vote_power: @event_hub.vote_power } }
    end

    assert_redirected_to event_hub_url(EventHub.last)
  end

  test "should show event_hub" do
    get event_hub_url(@event_hub)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_hub_url(@event_hub)
    assert_response :success
  end

  test "should update event_hub" do
    patch event_hub_url(@event_hub), params: { event_hub: { capital: @event_hub.capital, coop_event_id: @event_hub.coop_event_id, cooperative_id: @event_hub.cooperative_id, vote_code: @event_hub.vote_code, vote_power: @event_hub.vote_power } }
    assert_redirected_to event_hub_url(@event_hub)
  end

  test "should destroy event_hub" do
    assert_difference("EventHub.count", -1) do
      delete event_hub_url(@event_hub)
    end

    assert_redirected_to event_hubs_url
  end
end
