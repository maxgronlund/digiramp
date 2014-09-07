require 'test_helper'

class DevelopmentLogControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
