require 'rails_helper'

RSpec.describe "shop/stripe_transfers/index", type: :view do
  before(:each) do
    assign(:shop_stripe_transfers, [
      Shop::StripeTransfer.create!(
        :shop_order_item => nil,
        :shop_order => nil,
        :user => nil,
        :split => "9.99"
      ),
      Shop::StripeTransfer.create!(
        :shop_order_item => nil,
        :shop_order => nil,
        :user => nil,
        :split => "9.99"
      )
    ])
  end

  it "renders a list of shop/stripe_transfers" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
