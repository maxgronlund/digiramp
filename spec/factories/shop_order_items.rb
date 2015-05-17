FactoryGirl.define do
  factory :shop_order_item, :class => 'Shop::OrderItem' do
    order nil
product nil
  end

end
