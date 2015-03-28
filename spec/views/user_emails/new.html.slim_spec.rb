require 'rails_helper'

RSpec.describe "user_emails/new", :type => :view do
  before(:each) do
    assign(:user_email, UserEmail.new(
      :email => "MyString",
      :user => nil
    ))
  end

  it "renders new user_email form" do
    render

    assert_select "form[action=?][method=?]", user_emails_path, "post" do

      assert_select "input#user_email_email[name=?]", "user_email[email]"

      assert_select "input#user_email_user_id[name=?]", "user_email[user_id]"
    end
  end
end
