require 'test_helper'

class MailCampaignsControllerTest < ActionController::TestCase
  setup do
    @mail_campaign = mail_campaigns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mail_campaigns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mail_campaign" do
    assert_difference('MailCampaign.count') do
      post :create, mail_campaign: { account_id: @mail_campaign.account_id, from_email: @mail_campaign.from_email, from_title: @mail_campaign.from_title, mail_layout_id: @mail_campaign.mail_layout_id, subscribtion_message: @mail_campaign.subscribtion_message, title: @mail_campaign.title, user_id: @mail_campaign.user_id }
    end

    assert_redirected_to mail_campaign_path(assigns(:mail_campaign))
  end

  test "should show mail_campaign" do
    get :show, id: @mail_campaign
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mail_campaign
    assert_response :success
  end

  test "should update mail_campaign" do
    patch :update, id: @mail_campaign, mail_campaign: { account_id: @mail_campaign.account_id, from_email: @mail_campaign.from_email, from_title: @mail_campaign.from_title, mail_layout_id: @mail_campaign.mail_layout_id, subscribtion_message: @mail_campaign.subscribtion_message, title: @mail_campaign.title, user_id: @mail_campaign.user_id }
    assert_redirected_to mail_campaign_path(assigns(:mail_campaign))
  end

  test "should destroy mail_campaign" do
    assert_difference('MailCampaign.count', -1) do
      delete :destroy, id: @mail_campaign
    end

    assert_redirected_to mail_campaigns_path
  end
end
