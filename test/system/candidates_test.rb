require "application_system_test_case"

class CandidatesTest < ApplicationSystemTestCase
  setup do
    @candidate = candidates(:one)
  end

  test "visiting the index" do
    visit candidates_url
    assert_selector "h1", text: "Candidates"
  end

  test "should create candidate" do
    visit candidates_url
    click_on "New candidate"

    fill_in "Address", with: @candidate.address
    fill_in "Birth date", with: @candidate.birth_date
    fill_in "Company", with: @candidate.company
    fill_in "Education", with: @candidate.education
    fill_in "Elect position", with: @candidate.elect_position_id
    fill_in "Email", with: @candidate.email
    fill_in "Event hub", with: @candidate.event_hub_id
    fill_in "First name", with: @candidate.first_name
    fill_in "Last name", with: @candidate.last_name
    fill_in "Middle name", with: @candidate.middle_name
    fill_in "Mobile number", with: @candidate.mobile_number
    fill_in "Occupation", with: @candidate.occupation
    fill_in "Status", with: @candidate.status
    fill_in "Suffix", with: @candidate.suffix
    click_on "Create Candidate"

    assert_text "Candidate was successfully created"
    click_on "Back"
  end

  test "should update Candidate" do
    visit candidate_url(@candidate)
    click_on "Edit this candidate", match: :first

    fill_in "Address", with: @candidate.address
    fill_in "Birth date", with: @candidate.birth_date
    fill_in "Company", with: @candidate.company
    fill_in "Education", with: @candidate.education
    fill_in "Elect position", with: @candidate.elect_position_id
    fill_in "Email", with: @candidate.email
    fill_in "Event hub", with: @candidate.event_hub_id
    fill_in "First name", with: @candidate.first_name
    fill_in "Last name", with: @candidate.last_name
    fill_in "Middle name", with: @candidate.middle_name
    fill_in "Mobile number", with: @candidate.mobile_number
    fill_in "Occupation", with: @candidate.occupation
    fill_in "Status", with: @candidate.status
    fill_in "Suffix", with: @candidate.suffix
    click_on "Update Candidate"

    assert_text "Candidate was successfully updated"
    click_on "Back"
  end

  test "should destroy Candidate" do
    visit candidate_url(@candidate)
    click_on "Destroy this candidate", match: :first

    assert_text "Candidate was successfully destroyed"
  end
end
