require 'rails_helper'

RSpec.describe "cms_horizontal_links/new", :type => :view do
  before(:each) do
    assign(:cms_horizontal_link, CmsHorizontalLink.new(
      :recording => nil
    ))
  end

  it "renders new cms_horizontal_link form" do
    render

    assert_select "form[action=?][method=?]", cms_horizontal_links_path, "post" do

      assert_select "input#cms_horizontal_link_recording_id[name=?]", "cms_horizontal_link[recording_id]"
    end
  end
end
