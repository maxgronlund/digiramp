require 'rails_helper'

RSpec.describe "campaigns/edit", :type => :view do
  before(:each) do
    @campaign = assign(:campaign, Campaign.create!(
      :title => "MyString",
      :body => "MyText",
      :user => nil,
      :account => nil,
      :status => "MyString",
      :emails => "MyText"
    ))
  end

  it "renders the edit campaign form" do
    render

    assert_select "form[action=?][method=?]", campaign_path(@campaign), "post" do

      assert_select "input#campaign_title[name=?]", "campaign[title]"

      assert_select "textarea#campaign_body[name=?]", "campaign[body]"

      assert_select "input#campaign_user_id[name=?]", "campaign[user_id]"

      assert_select "input#campaign_account_id[name=?]", "campaign[account_id]"

      assert_select "input#campaign_status[name=?]", "campaign[status]"

      assert_select "textarea#campaign_emails[name=?]", "campaign[emails]"
    end
  end
end
