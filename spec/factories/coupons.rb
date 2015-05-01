FactoryGirl.define do
  factory :coupon do
    percent_off 1
    duration "MyString"
    duration_in_month 1
    stripe_id "MyString"
    currency "MyString"
    max_redemptions 1
    metadata "MyText"
    redeem_by "2015-04-29 19:11:39"
    user nil
    account nil
  end

end
