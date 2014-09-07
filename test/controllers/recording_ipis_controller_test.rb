require 'test_helper'

class RecordingIpisControllerTest < ActionController::TestCase
  setup do
    @recording_ipi = recording_ipis(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:recording_ipis)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create recording_ipi" do
    assert_difference('RecordingIpi.count') do
      post :create, recording_ipi: { name: @recording_ipi.name, recording_id: @recording_ipi.recording_id, role: @recording_ipi.role, share: @recording_ipi.share, user_id: @recording_ipi.user_id, user_uuid: @recording_ipi.user_uuid }
    end

    assert_redirected_to recording_ipi_path(assigns(:recording_ipi))
  end

  test "should show recording_ipi" do
    get :show, id: @recording_ipi
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @recording_ipi
    assert_response :success
  end

  test "should update recording_ipi" do
    patch :update, id: @recording_ipi, recording_ipi: { name: @recording_ipi.name, recording_id: @recording_ipi.recording_id, role: @recording_ipi.role, share: @recording_ipi.share, user_id: @recording_ipi.user_id, user_uuid: @recording_ipi.user_uuid }
    assert_redirected_to recording_ipi_path(assigns(:recording_ipi))
  end

  test "should destroy recording_ipi" do
    assert_difference('RecordingIpi.count', -1) do
      delete :destroy, id: @recording_ipi
    end

    assert_redirected_to recording_ipis_path
  end
end
