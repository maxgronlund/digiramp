require 'rails_helper'

RSpec.describe "campaigns/index", :type => :view do
  before(:each) do
    assign(:campaigns, [
      Campaign.create!(
        :title => "Title",
        :body => "MyText",
        :user => nil,
        :account => nil,
        :status => "Status",
        :emails => "MyText"
      ),
      Campaign.create!(
        :title => "Title",
        :body => "MyText",
        :user => nil,
        :account => nil,
        :status => "Status",
        :emails => "MyText"
      )
    ])
  end

  it "renders a list of campaigns" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
