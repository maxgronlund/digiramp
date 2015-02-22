require 'rails_helper'

RSpec.describe "user/cms_contacts/edit", :type => :view do
  before(:each) do
    @user_cms_contact = assign(:user_cms_contact, User::CmsContact.create!(
      :message => "MyString"
    ))
  end

  it "renders the edit user_cms_contact form" do
    render

    assert_select "form[action=?][method=?]", user_cms_contact_path(@user_cms_contact), "post" do

      assert_select "input#user_cms_contact_message[name=?]", "user_cms_contact[message]"
    end
  end
end
