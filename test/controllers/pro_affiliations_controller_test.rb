require 'test_helper'

class ProAffiliationsControllerTest < ActionController::TestCase
  setup do
    @pro_affiliation = pro_affiliations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pro_affiliations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pro_affiliation" do
    assert_difference('ProAffiliation.count') do
      post :create, pro_affiliation: { country: @pro_affiliation.country, title: @pro_affiliation.title, web: @pro_affiliation.web }
    end

    assert_redirected_to pro_affiliation_path(assigns(:pro_affiliation))
  end

  test "should show pro_affiliation" do
    get :show, id: @pro_affiliation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pro_affiliation
    assert_response :success
  end

  test "should update pro_affiliation" do
    patch :update, id: @pro_affiliation, pro_affiliation: { country: @pro_affiliation.country, title: @pro_affiliation.title, web: @pro_affiliation.web }
    assert_redirected_to pro_affiliation_path(assigns(:pro_affiliation))
  end

  test "should destroy pro_affiliation" do
    assert_difference('ProAffiliation.count', -1) do
      delete :destroy, id: @pro_affiliation
    end

    assert_redirected_to pro_affiliations_path
  end
end
