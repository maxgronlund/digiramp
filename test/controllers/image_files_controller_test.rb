require 'test_helper'

class ImageFilesControllerTest < ActionController::TestCase
  setup do
    @image_file = image_files(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:image_files)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create image_file" do
    assert_difference('ImageFile.count') do
      post :create, image_file: { account_id: @image_file.account_id, body: @image_file.body, file: @image_file.file, title: @image_file.title }
    end

    assert_redirected_to image_file_path(assigns(:image_file))
  end

  test "should show image_file" do
    get :show, id: @image_file
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @image_file
    assert_response :success
  end

  test "should update image_file" do
    patch :update, id: @image_file, image_file: { account_id: @image_file.account_id, body: @image_file.body, file: @image_file.file, title: @image_file.title }
    assert_redirected_to image_file_path(assigns(:image_file))
  end

  test "should destroy image_file" do
    assert_difference('ImageFile.count', -1) do
      delete :destroy, id: @image_file
    end

    assert_redirected_to image_files_path
  end
end
