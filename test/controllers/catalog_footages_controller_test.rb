require 'test_helper'

class CatalogFootagesControllerTest < ActionController::TestCase
  setup do
    @catalog_footage = catalog_footages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catalog_footages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catalog_footage" do
    assert_difference('CatalogFootage.count') do
      post :create, catalog_footage: {  }
    end

    assert_redirected_to catalog_footage_path(assigns(:catalog_footage))
  end

  test "should show catalog_footage" do
    get :show, id: @catalog_footage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @catalog_footage
    assert_response :success
  end

  test "should update catalog_footage" do
    patch :update, id: @catalog_footage, catalog_footage: {  }
    assert_redirected_to catalog_footage_path(assigns(:catalog_footage))
  end

  test "should destroy catalog_footage" do
    assert_difference('CatalogFootage.count', -1) do
      delete :destroy, id: @catalog_footage
    end

    assert_redirected_to catalog_footages_path
  end
end
