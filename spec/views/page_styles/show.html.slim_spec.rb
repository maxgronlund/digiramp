require 'rails_helper'

RSpec.describe "page_styles/show", :type => :view do
  before(:each) do
    @page_style = assign(:page_style, PageStyle.create!(
      :title => "Title",
      :css_tag => "Css Tag",
      :backdrop_image => "Backdrop Image",
      :show_backdrop => "Show Backdrop",
      :bgcolor => "Bgcolor"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Css Tag/)
    expect(rendered).to match(/Backdrop Image/)
    expect(rendered).to match(/Show Backdrop/)
    expect(rendered).to match(/Bgcolor/)
  end
end
