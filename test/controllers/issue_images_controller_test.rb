require 'test_helper'

class IssueImagesControllerTest < ActionController::TestCase
  setup do
    @issue_image = issue_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:issue_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create issue_image" do
    assert_difference('IssueImage.count') do
      post :create, issue_image: { show: @issue_image.show }
    end

    assert_redirected_to issue_image_path(assigns(:issue_image))
  end

  test "should show issue_image" do
    get :show, id: @issue_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @issue_image
    assert_response :success
  end

  test "should update issue_image" do
    patch :update, id: @issue_image, issue_image: { show: @issue_image.show }
    assert_redirected_to issue_image_path(assigns(:issue_image))
  end

  test "should destroy issue_image" do
    assert_difference('IssueImage.count', -1) do
      delete :destroy, id: @issue_image
    end

    assert_redirected_to issue_images_path
  end
end
