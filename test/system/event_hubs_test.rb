require "application_system_test_case"

class EventHubsTest < ApplicationSystemTestCase
  setup do
    @event_hub = event_hubs(:one)
  end

  test "visiting the index" do
    visit event_hubs_url
    assert_selector "h1", text: "Event hubs"
  end

  test "should create event hub" do
    visit event_hubs_url
    click_on "New event hub"

    fill_in "Capital", with: @event_hub.capital
    fill_in "Coop event", with: @event_hub.coop_event_id
    fill_in "Cooperative", with: @event_hub.cooperative_id
    fill_in "Vote code", with: @event_hub.vote_code
    fill_in "Vote power", with: @event_hub.vote_power
    click_on "Create Event hub"

    assert_text "Event hub was successfully created"
    click_on "Back"
  end

  test "should update Event hub" do
    visit event_hub_url(@event_hub)
    click_on "Edit this event hub", match: :first

    fill_in "Capital", with: @event_hub.capital
    fill_in "Coop event", with: @event_hub.coop_event_id
    fill_in "Cooperative", with: @event_hub.cooperative_id
    fill_in "Vote code", with: @event_hub.vote_code
    fill_in "Vote power", with: @event_hub.vote_power
    click_on "Update Event hub"

    assert_text "Event hub was successfully updated"
    click_on "Back"
  end

  test "should destroy Event hub" do
    visit event_hub_url(@event_hub)
    click_on "Destroy this event hub", match: :first

    assert_text "Event hub was successfully destroyed"
  end
end
