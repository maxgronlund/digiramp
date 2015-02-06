require 'rails_helper'

RSpec.describe "cms_sections/index", :type => :view do
  before(:each) do
    assign(:cms_sections, [
      CmsSection.create!(
        :page => nil,
        :position => 1,
        :cms_type => "Cms Type",
        :cms_module => nil
      ),
      CmsSection.create!(
        :page => nil,
        :position => 1,
        :cms_type => "Cms Type",
        :cms_module => nil
      )
    ])
  end

  it "renders a list of cms_sections" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Cms Type".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
