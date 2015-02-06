require 'rails_helper'

RSpec.describe "cms_recordings/edit", :type => :view do
  before(:each) do
    @cms_recording = assign(:cms_recording, CmsRecording.create!(
      :recording => nil
    ))
  end

  it "renders the edit cms_recording form" do
    render

    assert_select "form[action=?][method=?]", cms_recording_path(@cms_recording), "post" do

      assert_select "input#cms_recording_recording_id[name=?]", "cms_recording[recording_id]"
    end
  end
end
