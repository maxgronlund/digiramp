require 'test_helper'

class SellingPointsControllerTest < ActionController::TestCase
  test "should get selling_point_1" do
    get :selling_point_1
    assert_response :success
  end

  test "should get selling_point_2" do
    get :selling_point_2
    assert_response :success
  end

  test "should get selling_point_3" do
    get :selling_point_3
    assert_response :success
  end

end
