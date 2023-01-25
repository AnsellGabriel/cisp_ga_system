require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @registration = registrations(:one)
  end

  test "should get index" do
    get registrations_url
    assert_response :success
  end

  test "should get new" do
    get new_registration_url
    assert_response :success
  end

  test "should create registration" do
    assert_difference("Registration.count") do
      post registrations_url, params: { registration: { attendance: @registration.attendance, birth_date: @registration.birth_date, email: @registration.email, event_hub_id: @registration.event_hub_id, first_name: @registration.first_name, guest_type: @registration.guest_type, last_name: @registration.last_name, middle_name: @registration.middle_name, mobile_number: @registration.mobile_number } }
    end

    assert_redirected_to registration_url(Registration.last)
  end

  test "should show registration" do
    get registration_url(@registration)
    assert_response :success
  end

  test "should get edit" do
    get edit_registration_url(@registration)
    assert_response :success
  end

  test "should update registration" do
    patch registration_url(@registration), params: { registration: { attendance: @registration.attendance, birth_date: @registration.birth_date, email: @registration.email, event_hub_id: @registration.event_hub_id, first_name: @registration.first_name, guest_type: @registration.guest_type, last_name: @registration.last_name, middle_name: @registration.middle_name, mobile_number: @registration.mobile_number } }
    assert_redirected_to registration_url(@registration)
  end

  test "should destroy registration" do
    assert_difference("Registration.count", -1) do
      delete registration_url(@registration)
    end

    assert_redirected_to registrations_url
  end
end
