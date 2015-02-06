require 'rails_helper'

RSpec.describe "cms_recordings/index", :type => :view do
  before(:each) do
    assign(:cms_recordings, [
      CmsRecording.create!(
        :recording => nil
      ),
      CmsRecording.create!(
        :recording => nil
      )
    ])
  end

  it "renders a list of cms_recordings" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
