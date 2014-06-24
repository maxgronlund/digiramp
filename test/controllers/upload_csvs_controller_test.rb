require 'test_helper'

class UploadCsvsControllerTest < ActionController::TestCase
  setup do
    @upload_csv = upload_csvs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:upload_csvs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create upload_csv" do
    assert_difference('UploadCsv.count') do
      post :create, upload_csv: { account_id: @upload_csv.account_id, body: @upload_csv.body, catalog_id: @upload_csv.catalog_id, common_works_count: @upload_csv.common_works_count, title: @upload_csv.title, user_email: @upload_csv.user_email }
    end

    assert_redirected_to upload_csv_path(assigns(:upload_csv))
  end

  test "should show upload_csv" do
    get :show, id: @upload_csv
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @upload_csv
    assert_response :success
  end

  test "should update upload_csv" do
    patch :update, id: @upload_csv, upload_csv: { account_id: @upload_csv.account_id, body: @upload_csv.body, catalog_id: @upload_csv.catalog_id, common_works_count: @upload_csv.common_works_count, title: @upload_csv.title, user_email: @upload_csv.user_email }
    assert_redirected_to upload_csv_path(assigns(:upload_csv))
  end

  test "should destroy upload_csv" do
    assert_difference('UploadCsv.count', -1) do
      delete :destroy, id: @upload_csv
    end

    assert_redirected_to upload_csvs_path
  end
end
