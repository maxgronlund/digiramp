require 'rails_helper'

RSpec.describe "user_emails/edit", :type => :view do
  before(:each) do
    @user_email = assign(:user_email, UserEmail.create!(
      :email => "MyString",
      :user => nil
    ))
  end

  it "renders the edit user_email form" do
    render

    assert_select "form[action=?][method=?]", user_email_path(@user_email), "post" do

      assert_select "input#user_email_email[name=?]", "user_email[email]"

      assert_select "input#user_email_user_id[name=?]", "user_email[user_id]"
    end
  end
end
