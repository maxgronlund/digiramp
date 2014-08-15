require 'test_helper'

class PlayerAlphasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
