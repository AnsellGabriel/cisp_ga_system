require "application_system_test_case"

class ParticipantsTest < ApplicationSystemTestCase
  setup do
    @participant = participants(:one)
  end

  test "visiting the index" do
    visit participants_url
    assert_selector "h1", text: "Participants"
  end

  test "should create participant" do
    visit participants_url
    click_on "New participant"

    fill_in "Attendance channel", with: @participant.attendance_channel
    fill_in "Birth date", with: @participant.birth_date
    fill_in "Email", with: @participant.email
    fill_in "Event hub", with: @participant.event_hub_id
    fill_in "First name", with: @participant.first_name
    fill_in "Guest type", with: @participant.guest_type
    fill_in "Last name", with: @participant.last_name
    fill_in "Middle name", with: @participant.middle_name
    fill_in "Mobile number", with: @participant.mobile_number
    click_on "Create Participant"

    assert_text "Participant was successfully created"
    click_on "Back"
  end

  test "should update Participant" do
    visit participant_url(@participant)
    click_on "Edit this participant", match: :first

    fill_in "Attendance channel", with: @participant.attendance_channel
    fill_in "Birth date", with: @participant.birth_date
    fill_in "Email", with: @participant.email
    fill_in "Event hub", with: @participant.event_hub_id
    fill_in "First name", with: @participant.first_name
    fill_in "Guest type", with: @participant.guest_type
    fill_in "Last name", with: @participant.last_name
    fill_in "Middle name", with: @participant.middle_name
    fill_in "Mobile number", with: @participant.mobile_number
    click_on "Update Participant"

    assert_text "Participant was successfully updated"
    click_on "Back"
  end

  test "should destroy Participant" do
    visit participant_url(@participant)
    click_on "Destroy this participant", match: :first

    assert_text "Participant was successfully destroyed"
  end
end
