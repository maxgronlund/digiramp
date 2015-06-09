require 'rails_helper'

RSpec.describe "shop/stripe_transfers/new", type: :view do
  before(:each) do
    assign(:shop_stripe_transfer, Shop::StripeTransfer.new(
      :shop_order_item => nil,
      :shop_order => nil,
      :user => nil,
      :split => "9.99"
    ))
  end

  it "renders new shop_stripe_transfer form" do
    render

    assert_select "form[action=?][method=?]", shop_stripe_transfers_path, "post" do

      assert_select "input#shop_stripe_transfer_shop_order_item_id[name=?]", "shop_stripe_transfer[shop_order_item_id]"

      assert_select "input#shop_stripe_transfer_shop_order_id[name=?]", "shop_stripe_transfer[shop_order_id]"

      assert_select "input#shop_stripe_transfer_user_id[name=?]", "shop_stripe_transfer[user_id]"

      assert_select "input#shop_stripe_transfer_split[name=?]", "shop_stripe_transfer[split]"
    end
  end
end
