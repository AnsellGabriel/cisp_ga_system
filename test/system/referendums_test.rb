require "application_system_test_case"

class ReferendumsTest < ApplicationSystemTestCase
  setup do
    @referendum = referendums(:one)
  end

  test "visiting the index" do
    visit referendums_url
    assert_selector "h1", text: "Referendums"
  end

  test "should create referendum" do
    visit referendums_url
    click_on "New referendum"

    check "Active" if @referendum.active
    fill_in "Name", with: @referendum.name
    click_on "Create Referendum"

    assert_text "Referendum was successfully created"
    click_on "Back"
  end

  test "should update Referendum" do
    visit referendum_url(@referendum)
    click_on "Edit this referendum", match: :first

    check "Active" if @referendum.active
    fill_in "Name", with: @referendum.name
    click_on "Update Referendum"

    assert_text "Referendum was successfully updated"
    click_on "Back"
  end

  test "should destroy Referendum" do
    visit referendum_url(@referendum)
    click_on "Destroy this referendum", match: :first

    assert_text "Referendum was successfully destroyed"
  end
end
