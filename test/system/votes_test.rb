require "application_system_test_case"

class VotesTest < ApplicationSystemTestCase
  setup do
    @vote = votes(:one)
  end

  test "visiting the index" do
    visit votes_url
    assert_selector "h1", text: "Votes"
  end

  test "should create vote" do
    visit votes_url
    click_on "New vote"

    fill_in "Candidate", with: @vote.candidate_id
    fill_in "Coop event", with: @vote.coop_event_id
    fill_in "Event hub", with: @vote.event_hub_id
    check "Post" if @vote.post
    fill_in "Vote amount", with: @vote.vote_amount
    fill_in "Vote entry", with: @vote.vote_entry
    click_on "Create Vote"

    assert_text "Vote was successfully created"
    click_on "Back"
  end

  test "should update Vote" do
    visit vote_url(@vote)
    click_on "Edit this vote", match: :first

    fill_in "Candidate", with: @vote.candidate_id
    fill_in "Coop event", with: @vote.coop_event_id
    fill_in "Event hub", with: @vote.event_hub_id
    check "Post" if @vote.post
    fill_in "Vote amount", with: @vote.vote_amount
    fill_in "Vote entry", with: @vote.vote_entry
    click_on "Update Vote"

    assert_text "Vote was successfully updated"
    click_on "Back"
  end

  test "should destroy Vote" do
    visit vote_url(@vote)
    click_on "Destroy this vote", match: :first

    assert_text "Vote was successfully destroyed"
  end
end
