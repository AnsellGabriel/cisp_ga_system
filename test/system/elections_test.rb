require "application_system_test_case"

class ElectionsTest < ApplicationSystemTestCase
  setup do
    @election = elections(:one)
  end

  test "visiting the index" do
    visit elections_url
    assert_selector "h1", text: "Elections"
  end

  test "should create election" do
    visit elections_url
    click_on "New election"

    fill_in "Event hub", with: @election.event_hub_id
    fill_in "Voter code", with: @election.voter_code
    click_on "Create Election"

    assert_text "Election was successfully created"
    click_on "Back"
  end

  test "should update Election" do
    visit election_url(@election)
    click_on "Edit this election", match: :first

    fill_in "Event hub", with: @election.event_hub_id
    fill_in "Voter code", with: @election.voter_code
    click_on "Update Election"

    assert_text "Election was successfully updated"
    click_on "Back"
  end

  test "should destroy Election" do
    visit election_url(@election)
    click_on "Destroy this election", match: :first

    assert_text "Election was successfully destroyed"
  end
end
