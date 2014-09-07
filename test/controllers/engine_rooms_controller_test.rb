require 'test_helper'

class EngineRoomsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
