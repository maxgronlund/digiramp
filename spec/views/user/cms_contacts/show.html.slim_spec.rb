require 'rails_helper'

RSpec.describe "user/cms_contacts/show", :type => :view do
  before(:each) do
    @user_cms_contact = assign(:user_cms_contact, User::CmsContact.create!(
      :message => "Message"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Message/)
  end
end
