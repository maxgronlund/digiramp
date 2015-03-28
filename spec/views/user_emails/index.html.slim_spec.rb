require 'rails_helper'

RSpec.describe "user_emails/index", :type => :view do
  before(:each) do
    assign(:user_emails, [
      UserEmail.create!(
        :email => "Email",
        :user => nil
      ),
      UserEmail.create!(
        :email => "Email",
        :user => nil
      )
    ])
  end

  it "renders a list of user_emails" do
    render
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
