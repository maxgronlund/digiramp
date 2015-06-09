require 'rails_helper'

RSpec.describe "playlist_emails/edit", type: :view do
  before(:each) do
    @playlist_email = assign(:playlist_email, PlaylistEmail.create!(
      :emails => "MyText",
      :title => "MyString",
      :body => "MyText",
      :attach_files => false,
      :playlist => nil,
      :user => nil,
      :account => nil
    ))
  end

  it "renders the edit playlist_email form" do
    render

    assert_select "form[action=?][method=?]", playlist_email_path(@playlist_email), "post" do

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
