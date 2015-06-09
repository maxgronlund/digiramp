FactoryGirl.define do
  factory :shop_stripe_transfer, :class => 'Shop::StripeTransfer' do
    shop_order_item nil
shop_order nil
user nil
split "9.99"
due_date "2015-06-07"
  end

end
