require 'rails_helper'

RSpec.describe "cms_vertical_links/edit", :type => :view do
  before(:each) do
    @cms_vertical_link = assign(:cms_vertical_link, CmsVerticalLink.create!(
      :recording => nil
    ))
  end

  it "renders the edit cms_vertical_link form" do
    render

    assert_select "form[action=?][method=?]", cms_vertical_link_path(@cms_vertical_link), "post" do

      assert_select "input#cms_vertical_link_recording_id[name=?]", "cms_vertical_link[recording_id]"
    end
  end
end
