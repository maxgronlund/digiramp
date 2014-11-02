require 'rails_helper'

RSpec.describe "share_on_twitters/new", :type => :view do
  before(:each) do
    assign(:share_on_twitter, ShareOnTwitter.new(
      :user => nil,
      :recording => nil,
      :message => "MyText"
    ))
  end

  it "renders new share_on_twitter form" do
    render

    assert_select "form[action=?][method=?]", share_on_twitters_path, "post" do

      assert_select "input#share_on_twitter_user_id[name=?]", "share_on_twitter[user_id]"

      assert_select "input#share_on_twitter_recording_id[name=?]", "share_on_twitter[recording_id]"

      assert_select "textarea#share_on_twitter_message[name=?]", "share_on_twitter[message]"
    end
  end
end
