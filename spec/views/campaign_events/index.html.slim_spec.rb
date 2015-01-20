require 'rails_helper'

RSpec.describe "campaign_events/index", :type => :view do
  before(:each) do
    assign(:campaign_events, [
      CampaignEvent.create!(
        :campaign => nil,
        :user => nil,
        :account => nil,
        :title => "Title",
        :body => "MyText",
        :campaign_type => "Campaign Type",
        :status => "Status"
      ),
      CampaignEvent.create!(
        :campaign => nil,
        :user => nil,
        :account => nil,
        :title => "Title",
        :body => "MyText",
        :campaign_type => "Campaign Type",
        :status => "Status"
      )
    ])
  end

  it "renders a list of campaign_events" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Campaign Type".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
