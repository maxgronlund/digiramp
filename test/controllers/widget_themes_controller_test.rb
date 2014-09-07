require 'test_helper'

class WidgetThemesControllerTest < ActionController::TestCase
  setup do
    @widget_theme = widget_themes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:widget_themes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create widget_theme" do
    assert_difference('WidgetTheme.count') do
      post :create, widget_theme: { background_color: @widget_theme.background_color, border_color: @widget_theme.border_color, heading_color: @widget_theme.heading_color, hover_color: @widget_theme.hover_color, text_color: @widget_theme.text_color, text_color: @widget_theme.text_color, waveform_back: @widget_theme.waveform_back }
    end

    assert_redirected_to widget_theme_path(assigns(:widget_theme))
  end

  test "should show widget_theme" do
    get :show, id: @widget_theme
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @widget_theme
    assert_response :success
  end

  test "should update widget_theme" do
    patch :update, id: @widget_theme, widget_theme: { background_color: @widget_theme.background_color, border_color: @widget_theme.border_color, heading_color: @widget_theme.heading_color, hover_color: @widget_theme.hover_color, text_color: @widget_theme.text_color, text_color: @widget_theme.text_color, waveform_back: @widget_theme.waveform_back }
    assert_redirected_to widget_theme_path(assigns(:widget_theme))
  end

  test "should destroy widget_theme" do
    assert_difference('WidgetTheme.count', -1) do
      delete :destroy, id: @widget_theme
    end

    assert_redirected_to widget_themes_path
  end
end
