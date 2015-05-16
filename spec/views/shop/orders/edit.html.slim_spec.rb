require 'rails_helper'

RSpec.describe "shop/orders/edit", :type => :view do
  before(:each) do
    @shop_order = assign(:shop_order, Shop::Order.create!(
      :user => nil,
      :stripe_customer => nil
    ))
  end

  it "renders the edit shop_order form" do
    render

    assert_select "form[action=?][method=?]", shop_order_path(@shop_order), "post" do

      assert_select "input#shop_order_user_id[name=?]", "shop_order[user_id]"

      assert_select "input#shop_order_stripe_customer_id[name=?]", "shop_order[stripe_customer_id]"
    end
  end
end
