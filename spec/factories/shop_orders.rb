FactoryGirl.define do
  factory :shop_order, :class => 'Shop::Order' do
    user nil
stripe_customer nil
  end

end
