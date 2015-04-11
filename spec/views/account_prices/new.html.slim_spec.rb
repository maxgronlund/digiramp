require 'rails_helper'

RSpec.describe "account_prices/new", :type => :view do
  before(:each) do
    assign(:account_price, AccountPrice.new(
      :subscription_fee => "9.99",
      :account_type => "MyString"
    ))
  end

  it "renders new account_price form" do
    render

    assert_select "form[action=?][method=?]", account_prices_path, "post" do

      assert_select "input#account_price_subscription_fee[name=?]", "account_price[subscription_fee]"

      assert_select "input#account_price_account_type[name=?]", "account_price[account_type]"
    end
  end
end
