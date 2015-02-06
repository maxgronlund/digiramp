require 'rails_helper'

RSpec.describe "cms_videos/show", :type => :view do
  before(:each) do
    @cms_video = assign(:cms_video, CmsVideo.create!(
      :position => 1,
      :snippet => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/MyText/)
  end
end
