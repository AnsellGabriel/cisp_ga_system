require "application_system_test_case"

class CoopEventsTest < ApplicationSystemTestCase
  setup do
    @coop_event = coop_events(:one)
  end

  test "visiting the index" do
    visit coop_events_url
    assert_selector "h1", text: "Coop events"
  end

  test "should create coop event" do
    visit coop_events_url
    click_on "New coop event"

    check "Active" if @coop_event.active
    fill_in "Description", with: @coop_event.description
    check "Election" if @coop_event.election
    fill_in "Event date", with: @coop_event.event_date
    fill_in "Name", with: @coop_event.name
    click_on "Create Coop event"

    assert_text "Coop event was successfully created"
    click_on "Back"
  end

  test "should update Coop event" do
    visit coop_event_url(@coop_event)
    click_on "Edit this coop event", match: :first

    check "Active" if @coop_event.active
    fill_in "Description", with: @coop_event.description
    check "Election" if @coop_event.election
    fill_in "Event date", with: @coop_event.event_date
    fill_in "Name", with: @coop_event.name
    click_on "Update Coop event"

    assert_text "Coop event was successfully updated"
    click_on "Back"
  end

  test "should destroy Coop event" do
    visit coop_event_url(@coop_event)
    click_on "Destroy this coop event", match: :first

    assert_text "Coop event was successfully destroyed"
  end
end
