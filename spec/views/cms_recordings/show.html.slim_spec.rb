require 'rails_helper'

RSpec.describe "cms_recordings/show", :type => :view do
  before(:each) do
    @cms_recording = assign(:cms_recording, CmsRecording.create!(
      :recording => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
