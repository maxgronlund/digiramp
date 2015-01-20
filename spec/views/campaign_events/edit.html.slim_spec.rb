require 'rails_helper'

RSpec.describe "campaign_events/edit", :type => :view do
  before(:each) do
    @campaign_event = assign(:campaign_event, CampaignEvent.create!(
      :campaign => nil,
      :user => nil,
      :account => nil,
      :title => "MyString",
      :body => "MyText",
      :campaign_type => "MyString",
      :status => "MyString"
    ))
  end

  it "renders the edit campaign_event form" do
    render

    assert_select "form[action=?][method=?]", campaign_event_path(@campaign_event), "post" do

      assert_select "input#campaign_event_campaign_id[name=?]", "campaign_event[campaign_id]"

      assert_select "input#campaign_event_user_id[name=?]", "campaign_event[user_id]"

      assert_select "input#campaign_event_account_id[name=?]", "campaign_event[account_id]"

      assert_select "input#campaign_event_title[name=?]", "campaign_event[title]"

      assert_select "textarea#campaign_event_body[name=?]", "campaign_event[body]"

      assert_select "input#campaign_event_campaign_type[name=?]", "campaign_event[campaign_type]"

      assert_select "input#campaign_event_status[name=?]", "campaign_event[status]"
    end
  end
end
