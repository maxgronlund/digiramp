require 'rails_helper'

RSpec.describe "user_emails/show", :type => :view do
  before(:each) do
    @user_email = assign(:user_email, UserEmail.create!(
      :email => "Email",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Email/)
    expect(rendered).to match(//)
  end
end
