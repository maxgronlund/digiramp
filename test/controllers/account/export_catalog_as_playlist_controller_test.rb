require 'test_helper'

class Account::ExportCatalogAsPlaylistControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
