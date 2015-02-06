require 'rails_helper'

RSpec.describe "cms_videos/edit", :type => :view do
  before(:each) do
    @cms_video = assign(:cms_video, CmsVideo.create!(
      :position => 1,
      :snippet => "MyText"
    ))
  end

  it "renders the edit cms_video form" do
    render

    assert_select "form[action=?][method=?]", cms_video_path(@cms_video), "post" do

      assert_select "input#cms_video_position[name=?]", "cms_video[position]"

      assert_select "textarea#cms_video_snippet[name=?]", "cms_video[snippet]"
    end
  end
end
