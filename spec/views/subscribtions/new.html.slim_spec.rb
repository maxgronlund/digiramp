require 'rails_helper'

RSpec.describe "subscriptions/new", :type => :view do
  before(:each) do
    assign(:subscription, Subscription.new(
      :email => "MyString",
      :user => nil,
      :account => nil
    ))
  end

  it "renders new subscription form" do
    render

    assert_select "form[action=?][method=?]", subscriptions_path, "post" do

      assert_select "input#subscription_email[name=?]", "subscription[email]"

      assert_select "input#subscription_user_id[name=?]", "subscription[user_id]"

      assert_select "input#subscription_account_id[name=?]", "subscription[account_id]"
    end
  end
end
