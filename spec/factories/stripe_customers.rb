FactoryGirl.define do
  factory :stripe_customer do
    stripe_object "MyString"
    created "2015-05-06"
    stripe_id "MyString"
    livemode false
    description "MyString"
    email "MyString"
    delinquent false
    metadata "MyText"
    subscriptions "MyText"
    discount "MyText"
    account_balance 1
    currency "MyString"
    sources "MyText"
    default_source "MyString"
  end

end
