require 'test_helper'

class FootagesControllerTest < ActionController::TestCase
  setup do
    @footage = footages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:footages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create footage" do
    assert_difference('Footage.count') do
      post :create, footage: { body: @footage.body, copyright: @footage.copyright, footagable_type: @footage.footagable_type, footageable_id: @footage.footageable_id, mp4_file: @footage.mp4_file, thumb: @footage.thumb, title: @footage.title, transloadet: @footage.transloadet, uuid: @footage.uuid, webm_file: @footage.webm_file }
    end

    assert_redirected_to footage_path(assigns(:footage))
  end

  test "should show footage" do
    get :show, id: @footage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @footage
    assert_response :success
  end

  test "should update footage" do
    patch :update, id: @footage, footage: { body: @footage.body, copyright: @footage.copyright, footagable_type: @footage.footagable_type, footageable_id: @footage.footageable_id, mp4_file: @footage.mp4_file, thumb: @footage.thumb, title: @footage.title, transloadet: @footage.transloadet, uuid: @footage.uuid, webm_file: @footage.webm_file }
    assert_redirected_to footage_path(assigns(:footage))
  end

  test "should destroy footage" do
    assert_difference('Footage.count', -1) do
      delete :destroy, id: @footage
    end

    assert_redirected_to footages_path
  end
end
