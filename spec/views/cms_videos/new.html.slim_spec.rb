require 'rails_helper'

RSpec.describe "cms_videos/new", :type => :view do
  before(:each) do
    assign(:cms_video, CmsVideo.new(
      :position => 1,
      :snippet => "MyText"
    ))
  end

  it "renders new cms_video form" do
    render

    assert_select "form[action=?][method=?]", cms_videos_path, "post" do

      assert_select "input#cms_video_position[name=?]", "cms_video[position]"

      assert_select "textarea#cms_video_snippet[name=?]", "cms_video[snippet]"
    end
  end
end
