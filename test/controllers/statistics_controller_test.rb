require 'test_helper'

class StatisticsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get recordings" do
    get :recordings
    assert_response :success
  end

  test "should get common_works" do
    get :common_works
    assert_response :success
  end

  test "should get users" do
    get :users
    assert_response :success
  end

  test "should get ipis" do
    get :ipis
    assert_response :success
  end

end
