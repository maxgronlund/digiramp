require 'rails_helper'

RSpec.describe "recording_users/edit", type: :view do
  before(:each) do
    @recording_user = assign(:recording_user, RecordingUser.create!(
      :user => nil,
      :recording => nil,
      :email => "MyString"
    ))
  end

  it "renders the edit recording_user form" do
    render

    assert_select "form[action=?][method=?]", recording_user_path(@recording_user), "post" do

      assert_select "input#recording_user_user_id[name=?]", "recording_user[user_id]"

      assert_select "input#recording_user_recording_id[name=?]", "recording_user[recording_id]"

      assert_select "input#recording_user_email[name=?]", "recording_user[email]"
    end
  end
end
