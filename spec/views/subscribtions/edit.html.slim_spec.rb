require 'rails_helper'

RSpec.describe "subscriptions/edit", :type => :view do
  before(:each) do
    @subscription = assign(:subscription, ProUserSubscribtion.create!(
      :email => "MyString",
      :user => nil,
      :account => nil
    ))
  end

  it "renders the edit subscription form" do
    render

    assert_select "form[action=?][method=?]", subscription_path(@subscription), "post" do

      assert_select "input#subscription_email[name=?]", "subscription[email]"

      assert_select "input#subscription_user_id[name=?]", "subscription[user_id]"

      assert_select "input#subscription_account_id[name=?]", "subscription[account_id]"
    end
  end
end
