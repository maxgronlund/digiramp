require 'rails_helper'

RSpec.describe "shop/stripe_transfers/edit", type: :view do
  before(:each) do
    @shop_stripe_transfer = assign(:shop_stripe_transfer, Shop::StripeTransfer.create!(
      :shop_order_item => nil,
      :shop_order => nil,
      :user => nil,
      :split => "9.99"
    ))
  end

  it "renders the edit shop_stripe_transfer form" do
    render

    assert_select "form[action=?][method=?]", shop_stripe_transfer_path(@shop_stripe_transfer), "post" do

      assert_select "input#shop_stripe_transfer_shop_order_item_id[name=?]", "shop_stripe_transfer[shop_order_item_id]"

      assert_select "input#shop_stripe_transfer_shop_order_id[name=?]", "shop_stripe_transfer[shop_order_id]"

      assert_select "input#shop_stripe_transfer_user_id[name=?]", "shop_stripe_transfer[user_id]"

      assert_select "input#shop_stripe_transfer_split[name=?]", "shop_stripe_transfer[split]"
    end
  end
end
