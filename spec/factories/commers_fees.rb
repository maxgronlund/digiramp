FactoryGirl.define do
  factory :commers_fee do
    digiramp_percentage_fee ""
digiramp_flat_fee 1
stripe_percentage_fee "9.99"
stripe_flat_fee 1
  end

end
