require 'test_helper'

class ClientsControllerTest < ActionController::TestCase
  setup do
    @client = clients(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clients)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client" do
    assert_difference('Client.count') do
      post :create, client: { account_id: @client.account_id, address_home: @client.address_home, address_home: @client.address_home, email: @client.email, last_name: @client.last_name, name: @client.name, photo: @client.photo, revision: @client.revision, telephone_home: @client.telephone_home, telephone_work: @client.telephone_work, title: @client.title, user_uuid: @client.user_uuid, user_uuid: @client.user_uuid }
    end

    assert_redirected_to client_path(assigns(:client))
  end

  test "should show client" do
    get :show, id: @client
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @client
    assert_response :success
  end

  test "should update client" do
    patch :update, id: @client, client: { account_id: @client.account_id, address_home: @client.address_home, address_home: @client.address_home, email: @client.email, last_name: @client.last_name, name: @client.name, photo: @client.photo, revision: @client.revision, telephone_home: @client.telephone_home, telephone_work: @client.telephone_work, title: @client.title, user_uuid: @client.user_uuid, user_uuid: @client.user_uuid }
    assert_redirected_to client_path(assigns(:client))
  end

  test "should destroy client" do
    assert_difference('Client.count', -1) do
      delete :destroy, id: @client
    end

    assert_redirected_to clients_path
  end
end
