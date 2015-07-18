require 'rails_helper'

RSpec.describe "recording_users/new", type: :view do
  before(:each) do
    assign(:recording_user, RecordingUser.new(
      :user => nil,
      :recording => nil,
      :email => "MyString"
    ))
  end

  it "renders new recording_user form" do
    render

    assert_select "form[action=?][method=?]", recording_users_path, "post" do

      assert_select "input#recording_user_user_id[name=?]", "recording_user[user_id]"

      assert_select "input#recording_user_recording_id[name=?]", "recording_user[recording_id]"

      assert_select "input#recording_user_email[name=?]", "recording_user[email]"
    end
  end
end
