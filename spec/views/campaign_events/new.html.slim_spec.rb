require 'rails_helper'

RSpec.describe "campaign_events/new", :type => :view do
  before(:each) do
    assign(:campaign_event, CampaignEvent.new(
      :campaign => nil,
      :user => nil,
      :account => nil,
      :title => "MyString",
      :body => "MyText",
      :campaign_type => "MyString",
      :status => "MyString"
    ))
  end

  it "renders new campaign_event form" do
    render

    assert_select "form[action=?][method=?]", campaign_events_path, "post" do

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
