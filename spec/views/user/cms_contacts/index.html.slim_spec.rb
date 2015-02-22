require 'rails_helper'

RSpec.describe "user/cms_contacts/index", :type => :view do
  before(:each) do
    assign(:user_cms_contacts, [
      User::CmsContact.create!(
        :message => "Message"
      ),
      User::CmsContact.create!(
        :message => "Message"
      )
    ])
  end

  it "renders a list of user/cms_contacts" do
    render
    assert_select "tr>td", :text => "Message".to_s, :count => 2
  end
end
