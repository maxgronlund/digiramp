require 'rails_helper'

RSpec.describe "shop/physical_products/new", type: :view do
  before(:each) do
    assign(:shop_physical_product, Shop::PhysicalProduct.new(
      :dimensions => "MyString",
      :waight => "MyString",
      :shipping_cost => 1,
      :units_on_stock => 1
    ))
  end

  it "renders new shop_physical_product form" do
    render

    assert_select "form[action=?][method=?]", shop_physical_products_path, "post" do

      assert_select "input#shop_physical_product_dimensions[name=?]", "shop_physical_product[dimensions]"

      assert_select "input#shop_physical_product_waight[name=?]", "shop_physical_product[waight]"

      assert_select "input#shop_physical_product_shipping_cost[name=?]", "shop_physical_product[shipping_cost]"

      assert_select "input#shop_physical_product_units_on_stock[name=?]", "shop_physical_product[units_on_stock]"
    end
  end
end
