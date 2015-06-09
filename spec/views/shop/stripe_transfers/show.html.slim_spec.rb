require 'rails_helper'

RSpec.describe "shop/stripe_transfers/show", type: :view do
  before(:each) do
    @shop_stripe_transfer = assign(:shop_stripe_transfer, Shop::StripeTransfer.create!(
      :shop_order_item => nil,
      :shop_order => nil,
      :user => nil,
      :split => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/9.99/)
  end
end
