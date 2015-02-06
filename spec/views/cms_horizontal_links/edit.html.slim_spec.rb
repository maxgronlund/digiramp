require 'rails_helper'

RSpec.describe "cms_horizontal_links/edit", :type => :view do
  before(:each) do
    @cms_horizontal_link = assign(:cms_horizontal_link, CmsHorizontalLink.create!(
      :recording => nil
    ))
  end

  it "renders the edit cms_horizontal_link form" do
    render

    assert_select "form[action=?][method=?]", cms_horizontal_link_path(@cms_horizontal_link), "post" do

      assert_select "input#cms_horizontal_link_recording_id[name=?]", "cms_horizontal_link[recording_id]"
    end
  end
end
