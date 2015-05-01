FactoryGirl.define do
  factory :invoice do
    stripe_id "MyString"
stripe_object "MyString"
livemode false
amount_due 1
attempted false
closed false
currency "MyString"
stripe_customer_id "MyString"
date "2015-05-01"
forgiven false
lines "MyText"
paid false
period_start "2015-05-01"
period_end "2015-05-01"
starting_balance 1
subtotal 1
total 1
application_fee 1
charge "MyString"
description "MyString"
discount "MyText"
ending_balance 1
receipt_number "MyString"
statement_descriptor "MyString"
subscription_id "MyString"
metadata "MyText"
tax 1
tax_percent 1
user nil
account nil
  end

end
