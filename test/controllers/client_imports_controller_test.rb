require 'test_helper'

class ClientImportsControllerTest < ActionController::TestCase
  setup do
    @client_import = client_imports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:client_imports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client_import" do
    assert_difference('ClientImport.count') do
      post :create, client_import: { account_id: @client_import.account_id, file: @client_import.file, user_uuid: @client_import.user_uuid }
    end

    assert_redirected_to client_import_path(assigns(:client_import))
  end

  test "should show client_import" do
    get :show, id: @client_import
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @client_import
    assert_response :success
  end

  test "should update client_import" do
    patch :update, id: @client_import, client_import: { account_id: @client_import.account_id, file: @client_import.file, user_uuid: @client_import.user_uuid }
    assert_redirected_to client_import_path(assigns(:client_import))
  end

  test "should destroy client_import" do
    assert_difference('ClientImport.count', -1) do
      delete :destroy, id: @client_import
    end

    assert_redirected_to client_imports_path
  end
end
