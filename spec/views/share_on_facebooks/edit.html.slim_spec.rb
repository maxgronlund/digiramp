require 'rails_helper'

RSpec.describe "share_on_facebooks/edit", :type => :view do
  before(:each) do
    @share_on_facebook = assign(:share_on_facebook, ShareOnFacebook.create!(
      :user => nil,
      :recording => nil,
      :message => "MyText"
    ))
  end

  it "renders the edit share_on_facebook form" do
    render

    assert_select "form[action=?][method=?]", share_on_facebook_path(@share_on_facebook), "post" do

      assert_select "input#share_on_facebook_user_id[name=?]", "share_on_facebook[user_id]"

      assert_select "input#share_on_facebook_recording_id[name=?]", "share_on_facebook[recording_id]"

      assert_select "textarea#share_on_facebook_message[name=?]", "share_on_facebook[message]"
    end
  end
end
