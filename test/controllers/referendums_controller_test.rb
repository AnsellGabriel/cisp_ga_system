require "test_helper"

class ReferendumsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @referendum = referendums(:one)
  end

  test "should get index" do
    get referendums_url
    assert_response :success
  end

  test "should get new" do
    get new_referendum_url
    assert_response :success
  end

  test "should create referendum" do
    assert_difference("Referendum.count") do
      post referendums_url, params: { referendum: { active: @referendum.active, name: @referendum.name } }
    end

    assert_redirected_to referendum_url(Referendum.last)
  end

  test "should show referendum" do
    get referendum_url(@referendum)
    assert_response :success
  end

  test "should get edit" do
    get edit_referendum_url(@referendum)
    assert_response :success
  end

  test "should update referendum" do
    patch referendum_url(@referendum), params: { referendum: { active: @referendum.active, name: @referendum.name } }
    assert_redirected_to referendum_url(@referendum)
  end

  test "should destroy referendum" do
    assert_difference("Referendum.count", -1) do
      delete referendum_url(@referendum)
    end

    assert_redirected_to referendums_url
  end
end
