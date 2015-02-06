require 'rails_helper'

RSpec.describe "cms_recordings/new", :type => :view do
  before(:each) do
    assign(:cms_recording, CmsRecording.new(
      :recording => nil
    ))
  end

  it "renders new cms_recording form" do
    render

    assert_select "form[action=?][method=?]", cms_recordings_path, "post" do

      assert_select "input#cms_recording_recording_id[name=?]", "cms_recording[recording_id]"
    end
  end
end
