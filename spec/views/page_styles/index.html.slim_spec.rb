require 'rails_helper'

RSpec.describe "page_styles/index", :type => :view do
  before(:each) do
    assign(:page_styles, [
      PageStyle.create!(
        :title => "Title",
        :css_tag => "Css Tag",
        :backdrop_image => "Backdrop Image",
        :show_backdrop => "Show Backdrop",
        :bgcolor => "Bgcolor"
      ),
      PageStyle.create!(
        :title => "Title",
        :css_tag => "Css Tag",
        :backdrop_image => "Backdrop Image",
        :show_backdrop => "Show Backdrop",
        :bgcolor => "Bgcolor"
      )
    ])
  end

  it "renders a list of page_styles" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Css Tag".to_s, :count => 2
    assert_select "tr>td", :text => "Backdrop Image".to_s, :count => 2
    assert_select "tr>td", :text => "Show Backdrop".to_s, :count => 2
    assert_select "tr>td", :text => "Bgcolor".to_s, :count => 2
  end
end
