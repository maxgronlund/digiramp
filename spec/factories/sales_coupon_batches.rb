FactoryGirl.define do
  factory :sales_coupon_batch, :class => 'Sales::CouponBatch' do
    title "MyString"
    body "MyText"
    email "MyString"
    created_by "MyString"
  end

end
