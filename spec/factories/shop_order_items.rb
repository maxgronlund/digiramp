FactoryGirl.define do
  factory :shop_order_item, :class => 'Shop::OrderItem' do
    shop_order nil
shop_product nil
  end

end
