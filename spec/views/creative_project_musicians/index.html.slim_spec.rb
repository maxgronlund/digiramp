require 'rails_helper'

RSpec.describe "creative_project_roles/index", :type => :view do
  before(:each) do
    assign(:creative_project_roles, [
      CreativeProjectRole.create!(
        :creative_project => nil,
        :creative_project_user => nil,
        :instrument => "Instrument",
        :other_instrument => "Other Instrument"
      ),
      CreativeProjectRole.create!(
        :creative_project => nil,
        :creative_project_user => nil,
        :instrument => "Instrument",
        :other_instrument => "Other Instrument"
      )
    ])
  end

  it "renders a list of creative_project_roles" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Instrument".to_s, :count => 2
    assert_select "tr>td", :text => "Other Instrument".to_s, :count => 2
  end
end
