require 'test_helper'

class CustomerEventsControllerTest < ActionController::TestCase
  setup do
    @customer_event = customer_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customer_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer_event" do
    assert_difference('CustomerEvent.count') do
      post :create, customer_event: { account_id: @customer_event.account_id, action_type: @customer_event.action_type, body: @customer_event.body, customer_id: @customer_event.customer_id, event_type: @customer_event.event_type, follow_up_date: @customer_event.follow_up_date, folow_up: @customer_event.folow_up, title: @customer_event.title }
    end

    assert_redirected_to customer_event_path(assigns(:customer_event))
  end

  test "should show customer_event" do
    get :show, id: @customer_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer_event
    assert_response :success
  end

  test "should update customer_event" do
    patch :update, id: @customer_event, customer_event: { account_id: @customer_event.account_id, action_type: @customer_event.action_type, body: @customer_event.body, customer_id: @customer_event.customer_id, event_type: @customer_event.event_type, follow_up_date: @customer_event.follow_up_date, folow_up: @customer_event.folow_up, title: @customer_event.title }
    assert_redirected_to customer_event_path(assigns(:customer_event))
  end

  test "should destroy customer_event" do
    assert_difference('CustomerEvent.count', -1) do
      delete :destroy, id: @customer_event
    end

    assert_redirected_to customer_events_path
  end
end
