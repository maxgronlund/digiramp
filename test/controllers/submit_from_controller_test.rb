require 'test_helper'

class SubmitFromControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
