FactoryGirl.define do
  factory :shop_physical_product, :class => 'Shop::PhysicalProduct' do
    dimensions "MyString"
waight "MyString"
shipping_cost 1
units_on_stock 1
  end

end
