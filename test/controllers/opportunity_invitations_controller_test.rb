require 'test_helper'

class OpportunityInvitationsControllerTest < ActionController::TestCase
  setup do
    @opportunity_invitation = opportunity_invitations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:opportunity_invitations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create opportunity_invitation" do
    assert_difference('OpportunityInvitation.count') do
      post :create, opportunity_invitation: { body: @opportunity_invitation.body, invitees: @opportunity_invitation.invitees, opportunity_id: @opportunity_invitation.opportunity_id, title: @opportunity_invitation.title }
    end

    assert_redirected_to opportunity_invitation_path(assigns(:opportunity_invitation))
  end

  test "should show opportunity_invitation" do
    get :show, id: @opportunity_invitation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @opportunity_invitation
    assert_response :success
  end

  test "should update opportunity_invitation" do
    patch :update, id: @opportunity_invitation, opportunity_invitation: { body: @opportunity_invitation.body, invitees: @opportunity_invitation.invitees, opportunity_id: @opportunity_invitation.opportunity_id, title: @opportunity_invitation.title }
    assert_redirected_to opportunity_invitation_path(assigns(:opportunity_invitation))
  end

  test "should destroy opportunity_invitation" do
    assert_difference('OpportunityInvitation.count', -1) do
      delete :destroy, id: @opportunity_invitation
    end

    assert_redirected_to opportunity_invitations_path
  end
end
