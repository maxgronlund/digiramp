require 'rails_helper'

RSpec.describe "shop/physical_products/show", type: :view do
  before(:each) do
    @shop_physical_product = assign(:shop_physical_product, Shop::PhysicalProduct.create!(
      :dimensions => "Dimensions",
      :waight => "Waight",
      :shipping_cost => 1,
      :units_on_stock => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Dimensions/)
    expect(rendered).to match(/Waight/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
