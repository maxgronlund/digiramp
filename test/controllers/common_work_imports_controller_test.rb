require 'test_helper'

class CommonWorkImportsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get select_pro" do
    get :select_pro
    assert_response :success
  end

  test "should get from_ascap" do
    get :from_ascap
    assert_response :success
  end

  test "should get from_bmi" do
    get :from_bmi
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
