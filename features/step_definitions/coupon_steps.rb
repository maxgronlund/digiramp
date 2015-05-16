Then(/^I create a new coupon named "(.*?)"$/) do |name|
  
  find_by_id('new-coupon').click
  fill_in 'coupon_stripe_id', with: name
  
  fill_in 'coupon_percent_off', with: 50
  select 'repeating', :from => 'coupon_duration'
  fill_in 'coupon_duration_in_months', with: 6
  fill_in 'coupon_max_redemptions', with: 6
  select 'DigiRAMP Pro', :from => 'coupon_plan_id'
  find_by_id('commit-form').click

  find('.table-responsive')
  
end