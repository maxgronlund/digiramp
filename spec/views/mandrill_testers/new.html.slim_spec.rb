require 'rails_helper'

RSpec.describe "mandrill_testers/new", type: :view do
  before(:each) do
    assign(:mandrill_tester, MandrillTester.new(
      :email => "MyString",
      :subject => "MyString",
      :message => "MyText"
    ))
  end

  it "renders new mandrill_tester form" do
    render

    assert_select "form[action=?][method=?]", mandrill_testers_path, "post" do

      assert_select "input#mandrill_tester_email[name=?]", "mandrill_tester[email]"

      assert_select "input#mandrill_tester_subject[name=?]", "mandrill_tester[subject]"

      assert_select "textarea#mandrill_tester_message[name=?]", "mandrill_tester[message]"
    end
  end
end
