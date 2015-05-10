FactoryGirl.define do
  factory :plan do |f|
    f.stripe_id ""
    f.name "DigiRAMP Pro"
    f.description "Pro Digiramp plan"
    f.amount 1900
    f.currency "usd"
    f.interval "month"
    f.trial_period_days 0
    f.statement_descriptor "DIGIRAMP PRO PLAN"
    f.published true
  end

end
