require 'rails_helper'

RSpec.describe "share_on_twitters/index", :type => :view do
  before(:each) do
    assign(:share_on_twitters, [
      ShareOnTwitter.create!(
        :user => nil,
        :recording => nil,
        :message => "MyText"
      ),
      ShareOnTwitter.create!(
        :user => nil,
        :recording => nil,
        :message => "MyText"
      )
    ])
  end

  it "renders a list of share_on_twitters" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
