require 'rails_helper'

RSpec.describe "share_on_facebooks/index", :type => :view do
  before(:each) do
    assign(:share_on_facebooks, [
      ShareOnFacebook.create!(
        :user => nil,
        :recording => nil,
        :message => "MyText"
      ),
      ShareOnFacebook.create!(
        :user => nil,
        :recording => nil,
        :message => "MyText"
      )
    ])
  end

  it "renders a list of share_on_facebooks" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
