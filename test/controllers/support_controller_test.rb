require 'test_helper'

class SupportControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
