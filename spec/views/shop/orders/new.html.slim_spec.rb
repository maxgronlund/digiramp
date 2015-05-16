require 'rails_helper'

RSpec.describe "shop/orders/new", :type => :view do
  before(:each) do
    assign(:shop_order, Shop::Order.new(
      :user => nil,
      :stripe_customer => nil
    ))
  end

  it "renders new shop_order form" do
    render

    assert_select "form[action=?][method=?]", shop_orders_path, "post" do

      assert_select "input#shop_order_user_id[name=?]", "shop_order[user_id]"

      assert_select "input#shop_order_stripe_customer_id[name=?]", "shop_order[stripe_customer_id]"
    end
  end
end
