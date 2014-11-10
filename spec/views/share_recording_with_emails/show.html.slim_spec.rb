require 'rails_helper'

RSpec.describe "share_recording_with_emails/show", :type => :view do
  before(:each) do
    @share_recording_with_email = assign(:share_recording_with_email, ShareRecordingWithEmail.create!(
      :user => nil,
      :recording => nil,
      :recipients => "MyText",
      :title => "Title",
      :message => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
  end
end
