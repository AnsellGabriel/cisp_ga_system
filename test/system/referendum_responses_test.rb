require "application_system_test_case"

class ReferendumResponsesTest < ApplicationSystemTestCase
  setup do
    @referendum_response = referendum_responses(:one)
  end

  test "visiting the index" do
    visit referendum_responses_url
    assert_selector "h1", text: "Referendum responses"
  end

  test "should create referendum response" do
    visit referendum_responses_url
    click_on "New referendum response"

    fill_in "Event hub", with: @referendum_response.event_hub_id
    fill_in "Referendum", with: @referendum_response.referendum_id
    check "Response" if @referendum_response.response
    click_on "Create Referendum response"

    assert_text "Referendum response was successfully created"
    click_on "Back"
  end

  test "should update Referendum response" do
    visit referendum_response_url(@referendum_response)
    click_on "Edit this referendum response", match: :first

    fill_in "Event hub", with: @referendum_response.event_hub_id
    fill_in "Referendum", with: @referendum_response.referendum_id
    check "Response" if @referendum_response.response
    click_on "Update Referendum response"

    assert_text "Referendum response was successfully updated"
    click_on "Back"
  end

  test "should destroy Referendum response" do
    visit referendum_response_url(@referendum_response)
    click_on "Destroy this referendum response", match: :first

    assert_text "Referendum response was successfully destroyed"
  end
end
