require 'rails_helper'

RSpec.describe "shop/orders/index", :type => :view do
  before(:each) do
    assign(:shop_orders, [
      Shop::Order.create!(
        :user => nil,
        :stripe_customer => nil
      ),
      Shop::Order.create!(
        :user => nil,
        :stripe_customer => nil
      )
    ])
  end

  it "renders a list of shop/orders" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
