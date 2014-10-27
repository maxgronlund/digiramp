require 'rails_helper'

RSpec.describe "share_on_facebooks/new", :type => :view do
  before(:each) do
    assign(:share_on_facebook, ShareOnFacebook.new(
      :user => nil,
      :recording => nil,
      :message => "MyText"
    ))
  end

  it "renders new share_on_facebook form" do
    render

    assert_select "form[action=?][method=?]", share_on_facebooks_path, "post" do

      assert_select "input#share_on_facebook_user_id[name=?]", "share_on_facebook[user_id]"

      assert_select "input#share_on_facebook_recording_id[name=?]", "share_on_facebook[recording_id]"

      assert_select "textarea#share_on_facebook_message[name=?]", "share_on_facebook[message]"
    end
  end
end
