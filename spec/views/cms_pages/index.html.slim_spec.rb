require 'rails_helper'

RSpec.describe "cms_pages/index", :type => :view do
  before(:each) do
    assign(:cms_pages, [
      CmsPage.create!(
        :user => nil,
        :title => "Title"
      ),
      CmsPage.create!(
        :user => nil,
        :title => "Title"
      )
    ])
  end

  it "renders a list of cms_pages" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
