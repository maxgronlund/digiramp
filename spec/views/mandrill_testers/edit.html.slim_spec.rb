require 'rails_helper'

RSpec.describe "mandrill_testers/edit", type: :view do
  before(:each) do
    @mandrill_tester = assign(:mandrill_tester, MandrillTester.create!(
      :email => "MyString",
      :subject => "MyString",
      :message => "MyText"
    ))
  end

  it "renders the edit mandrill_tester form" do
    render

    assert_select "form[action=?][method=?]", mandrill_tester_path(@mandrill_tester), "post" do

      assert_select "input#mandrill_tester_email[name=?]", "mandrill_tester[email]"

      assert_select "input#mandrill_tester_subject[name=?]", "mandrill_tester[subject]"

      assert_select "textarea#mandrill_tester_message[name=?]", "mandrill_tester[message]"
    end
  end
end
