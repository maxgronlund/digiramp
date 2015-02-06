require 'rails_helper'

RSpec.describe "cms_vertical_links/new", :type => :view do
  before(:each) do
    assign(:cms_vertical_link, CmsVerticalLink.new(
      :recording => nil
    ))
  end

  it "renders new cms_vertical_link form" do
    render

    assert_select "form[action=?][method=?]", cms_vertical_links_path, "post" do

      assert_select "input#cms_vertical_link_recording_id[name=?]", "cms_vertical_link[recording_id]"
    end
  end
end
