require 'test_helper'

class FeaturesControllerTest < ActionController::TestCase
  setup do
    @feature = features(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:features)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create feature" do
    assert_difference('Feature.count') do
      post :create, feature: { body: @feature.body, title: @feature.title, video1_id: @feature.video1_id, video2_id: @feature.video2_id, video3_id: @feature.video3_id, video4_id: @feature.video4_id, video5_id: @feature.video5_id }
    end

    assert_redirected_to feature_path(assigns(:feature))
  end

  test "should show feature" do
    get :show, id: @feature
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @feature
    assert_response :success
  end

  test "should update feature" do
    patch :update, id: @feature, feature: { body: @feature.body, title: @feature.title, video1_id: @feature.video1_id, video2_id: @feature.video2_id, video3_id: @feature.video3_id, video4_id: @feature.video4_id, video5_id: @feature.video5_id }
    assert_redirected_to feature_path(assigns(:feature))
  end

  test "should destroy feature" do
    assert_difference('Feature.count', -1) do
      delete :destroy, id: @feature
    end

    assert_redirected_to features_path
  end
end
