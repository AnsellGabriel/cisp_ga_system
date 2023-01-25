require "application_system_test_case"

class ElectPositionsTest < ApplicationSystemTestCase
  setup do
    @elect_position = elect_positions(:one)
  end

  test "visiting the index" do
    visit elect_positions_url
    assert_selector "h1", text: "Elect positions"
  end

  test "should create elect position" do
    visit elect_positions_url
    click_on "New elect position"

    fill_in "Coop event", with: @elect_position.coop_event_id
    fill_in "Name", with: @elect_position.name
    fill_in "Vacant", with: @elect_position.vacant
    click_on "Create Elect position"

    assert_text "Elect position was successfully created"
    click_on "Back"
  end

  test "should update Elect position" do
    visit elect_position_url(@elect_position)
    click_on "Edit this elect position", match: :first

    fill_in "Coop event", with: @elect_position.coop_event_id
    fill_in "Name", with: @elect_position.name
    fill_in "Vacant", with: @elect_position.vacant
    click_on "Update Elect position"

    assert_text "Elect position was successfully updated"
    click_on "Back"
  end

  test "should destroy Elect position" do
    visit elect_position_url(@elect_position)
    click_on "Destroy this elect position", match: :first

    assert_text "Elect position was successfully destroyed"
  end
end
