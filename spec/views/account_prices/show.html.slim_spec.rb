require 'rails_helper'

RSpec.describe "account_prices/show", :type => :view do
  before(:each) do
    @account_price = assign(:account_price, AccountPrice.create!(
      :subscription_fee => "9.99",
      :account_type => "Account Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Account Type/)
  end
end
