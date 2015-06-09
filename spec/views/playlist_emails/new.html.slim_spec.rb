require 'rails_helper'

RSpec.describe "playlist_emails/new", type: :view do
  before(:each) do
    assign(:playlist_email, PlaylistEmail.new(
      :emails => "MyText",
      :title => "MyString",
      :body => "MyText",
      :attach_files => false,
      :playlist => nil,
      :user => nil,
      :account => nil
    ))
  end

  it "renders new playlist_email form" do
    render

    assert_select "form[action=?][method=?]", playlist_emails_path, "post" do

      assert_select "textarea#playlist_email_emails[name=?]", "playlist_email[emails]"

      assert_select "input#playlist_email_title[name=?]", "playlist_email[title]"

      assert_select "textarea#playlist_email_body[name=?]", "playlist_email[body]"

      assert_select "input#playlist_email_attach_files[name=?]", "playlist_email[attach_files]"

      assert_select "input#playlist_email_playlist_id[name=?]", "playlist_email[playlist_id]"

      assert_select "input#playlist_email_user_id[name=?]", "playlist_email[user_id]"

      assert_select "input#playlist_email_account_id[name=?]", "playlist_email[account_id]"
    end
  end
end
