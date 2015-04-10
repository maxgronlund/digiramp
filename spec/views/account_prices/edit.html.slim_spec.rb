require 'rails_helper'

RSpec.describe "account_prices/edit", :type => :view do
  before(:each) do
    @account_price = assign(:account_price, AccountPrice.create!(
      :subscription_fee => "9.99",
      :account_type => "MyString"
    ))
  end

  it "renders the edit account_price form" do
    render

    assert_select "form[action=?][method=?]", account_price_path(@account_price), "post" do

      assert_select "input#account_price_subscription_fee[name=?]", "account_price[subscription_fee]"

      assert_select "input#account_price_account_type[name=?]", "account_price[account_type]"
    end
  end
end
