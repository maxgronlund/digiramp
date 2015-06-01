require 'rails_helper'

RSpec.describe "shop/physical_products/index", type: :view do
  before(:each) do
    assign(:shop_physical_products, [
      Shop::PhysicalProduct.create!(
        :dimensions => "Dimensions",
        :waight => "Waight",
        :shipping_cost => 1,
        :units_on_stock => 2
      ),
      Shop::PhysicalProduct.create!(
        :dimensions => "Dimensions",
        :waight => "Waight",
        :shipping_cost => 1,
        :units_on_stock => 2
      )
    ])
  end

  it "renders a list of shop/physical_products" do
    render
    assert_select "tr>td", :text => "Dimensions".to_s, :count => 2
    assert_select "tr>td", :text => "Waight".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
