require 'rails_helper'

RSpec.describe "campaign_events/show", :type => :view do
  before(:each) do
    @campaign_event = assign(:campaign_event, CampaignEvent.create!(
      :campaign => nil,
      :user => nil,
      :account => nil,
      :title => "Title",
      :body => "MyText",
      :campaign_type => "Campaign Type",
      :status => "Status"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Campaign Type/)
    expect(rendered).to match(/Status/)
  end
end
