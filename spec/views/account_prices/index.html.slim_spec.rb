require 'rails_helper'

RSpec.describe "account_prices/index", :type => :view do
  before(:each) do
    assign(:account_prices, [
      AccountPrice.create!(
        :subscription_fee => "9.99",
        :account_type => "Account Type"
      ),
      AccountPrice.create!(
        :subscription_fee => "9.99",
        :account_type => "Account Type"
      )
    ])
  end

  it "renders a list of account_prices" do
    render
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Account Type".to_s, :count => 2
  end
end
