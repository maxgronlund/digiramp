require 'rails_helper'

RSpec.describe "shop/orders/show", :type => :view do
  before(:each) do
    @shop_order = assign(:shop_order, Shop::Order.create!(
      :user => nil,
      :stripe_customer => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
