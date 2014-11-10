require 'rails_helper'

RSpec.describe "share_recording_with_emails/index", :type => :view do
  before(:each) do
    assign(:share_recording_with_emails, [
      ShareRecordingWithEmail.create!(
        :user => nil,
        :recording => nil,
        :recipients => "MyText",
        :title => "Title",
        :message => "MyText"
      ),
      ShareRecordingWithEmail.create!(
        :user => nil,
        :recording => nil,
        :recipients => "MyText",
        :title => "Title",
        :message => "MyText"
      )
    ])
  end

  it "renders a list of share_recording_with_emails" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
