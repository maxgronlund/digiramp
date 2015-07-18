require 'rails_helper'

RSpec.describe "recording_users/index", type: :view do
  before(:each) do
    assign(:recording_users, [
      RecordingUser.create!(
        :user => nil,
        :recording => nil,
        :email => "Email"
      ),
      RecordingUser.create!(
        :user => nil,
        :recording => nil,
        :email => "Email"
      )
    ])
  end

  it "renders a list of recording_users" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
