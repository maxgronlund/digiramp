require 'rails_helper'

RSpec.describe "user/cms_contacts/new", :type => :view do
  before(:each) do
    assign(:user_cms_contact, User::CmsContact.new(
      :message => "MyString"
    ))
  end

  it "renders new user_cms_contact form" do
    render

    assert_select "form[action=?][method=?]", user_cms_contacts_path, "post" do

      assert_select "input#user_cms_contact_message[name=?]", "user_cms_contact[message]"
    end
  end
end
