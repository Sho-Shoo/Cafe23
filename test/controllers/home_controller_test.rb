require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest

  test "should get index" do
    get home_path
    assert_response :success
  end

  test "should be redirected to from index to time_clock_path of logged in as regular employee" do
    login_employee
    get home_path
    assert_redirected_to time_clock_path
  end

  test "should get about" do
    get about_path
    assert_response :success
  end

  test "should get contact" do
    get contact_path
    assert_response :success
  end

  test "should get privacy" do
    get privacy_path
    assert_response :success
  end

end