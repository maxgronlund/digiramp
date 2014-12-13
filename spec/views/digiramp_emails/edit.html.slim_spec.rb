require 'rails_helper'

RSpec.describe "digiramp_emails/edit", :type => :view do
  before(:each) do
    @digiramp_email = assign(:digiramp_email, DigirampEmail.create!(
      :email_group => nil,
      :email_layout => nil,
      :title => "MyString",
      :body => "MyText",
      :recipients => "MyText"
    ))
  end

  it "renders the edit digiramp_email form" do
    render

    assert_select "form[action=?][method=?]", digiramp_email_path(@digiramp_email), "post" do

      assert_select "input#digiramp_email_email_group_id[name=?]", "digiramp_email[email_group_id]"

      assert_select "input#digiramp_email_email_layout_id[name=?]", "digiramp_email[email_layout_id]"

      assert_select "input#digiramp_email_title[name=?]", "digiramp_email[title]"

      assert_select "textarea#digiramp_email_body[name=?]", "digiramp_email[body]"

      assert_select "textarea#digiramp_email_recipients[name=?]", "digiramp_email[recipients]"
    end
  end
end
