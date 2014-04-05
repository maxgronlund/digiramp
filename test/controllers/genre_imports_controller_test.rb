require 'test_helper'

class GenreImportsControllerTest < ActionController::TestCase
  setup do
    @genre_import = genre_imports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:genre_imports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create genre_import" do
    assert_difference('GenreImport.count') do
      post :create, genre_import: { file: @genre_import.file }
    end

    assert_redirected_to genre_import_path(assigns(:genre_import))
  end

  test "should show genre_import" do
    get :show, id: @genre_import
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @genre_import
    assert_response :success
  end

  test "should update genre_import" do
    patch :update, id: @genre_import, genre_import: { file: @genre_import.file }
    assert_redirected_to genre_import_path(assigns(:genre_import))
  end

  test "should destroy genre_import" do
    assert_difference('GenreImport.count', -1) do
      delete :destroy, id: @genre_import
    end

    assert_redirected_to genre_imports_path
  end
end
