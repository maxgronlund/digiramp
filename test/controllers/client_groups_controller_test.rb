require 'test_helper'

class ClientGroupsControllerTest < ActionController::TestCase
  setup do
    @client_group = client_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:client_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client_group" do
    assert_difference('ClientGroup.count') do
      post :create, client_group: { account_id: @client_group.account_id, title: @client_group.title }
    end

    assert_redirected_to client_group_path(assigns(:client_group))
  end

  test "should show client_group" do
    get :show, id: @client_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @client_group
    assert_response :success
  end

  test "should update client_group" do
    patch :update, id: @client_group, client_group: { account_id: @client_group.account_id, title: @client_group.title }
    assert_redirected_to client_group_path(assigns(:client_group))
  end

  test "should destroy client_group" do
    assert_difference('ClientGroup.count', -1) do
      delete :destroy, id: @client_group
    end

    assert_redirected_to client_groups_path
  end
end
