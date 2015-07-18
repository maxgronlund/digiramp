require 'rails_helper'

RSpec.describe "recording_users/show", type: :view do
  before(:each) do
    @recording_user = assign(:recording_user, RecordingUser.create!(
      :user => nil,
      :recording => nil,
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Email/)
  end
end
