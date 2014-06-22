require 'test_helper'

class OppertunitiesControllerTest < ActionController::TestCase
  setup do
    @oppertunity = oppertunities(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:oppertunities)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create oppertunity" do
    assert_difference('Oppertunity.count') do
      post :create, oppertunity: { account_id: @oppertunity.account_id, body: @oppertunity.body, budget: @oppertunity.budget, deadline: @oppertunity.deadline, kind: @oppertunity.kind, title: @oppertunity.title }
    end

    assert_redirected_to oppertunity_path(assigns(:oppertunity))
  end

  test "should show oppertunity" do
    get :show, id: @oppertunity
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @oppertunity
    assert_response :success
  end

  test "should update oppertunity" do
    patch :update, id: @oppertunity, oppertunity: { account_id: @oppertunity.account_id, body: @oppertunity.body, budget: @oppertunity.budget, deadline: @oppertunity.deadline, kind: @oppertunity.kind, title: @oppertunity.title }
    assert_redirected_to oppertunity_path(assigns(:oppertunity))
  end

  test "should destroy oppertunity" do
    assert_difference('Oppertunity.count', -1) do
      delete :destroy, id: @oppertunity
    end

    assert_redirected_to oppertunities_path
  end
end
