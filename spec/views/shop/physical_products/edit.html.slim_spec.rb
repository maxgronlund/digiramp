require 'rails_helper'

RSpec.describe "shop/physical_products/edit", type: :view do
  before(:each) do
    @shop_physical_product = assign(:shop_physical_product, Shop::PhysicalProduct.create!(
      :dimensions => "MyString",
      :waight => "MyString",
      :shipping_cost => 1,
      :units_on_stock => 1
    ))
  end

  it "renders the edit shop_physical_product form" do
    render

    assert_select "form[action=?][method=?]", shop_physical_product_path(@shop_physical_product), "post" do

      assert_select "input#shop_physical_product_dimensions[name=?]", "shop_physical_product[dimensions]"

      assert_select "input#shop_physical_product_waight[name=?]", "shop_physical_product[waight]"

      assert_select "input#shop_physical_product_shipping_cost[name=?]", "shop_physical_product[shipping_cost]"

      assert_select "input#shop_physical_product_units_on_stock[name=?]", "shop_physical_product[units_on_stock]"
    end
  end
end
