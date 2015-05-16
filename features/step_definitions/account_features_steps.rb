Given(/^there is an account feature named "(.*?)"$/) do |account_type|
  find_or_create_account_feature( account_type)
end

When(/^I'm on the edit account type feature page for the "(.*?)" account type$/) do |account_type|
  visit "/admin/account_features"
  find_by_id(account_type).click
  find('.edit_account_feature')
end

Given(/^there is a plan named "(.*?)" linked to an account type named "(.*?)"$/) do |plan_name, account_type|
  plan            = find_or_create_plan( plan_name)
  account_feature = find_or_create_account_feature( account_type)
  account_feature.plan_id = plan.id
  account_feature.save!
end

Given(/^there is an account type named "(.*?)"$/) do |account_type|
  account_feature = find_or_create_account_feature(account_type)
end





#Then(/^I create a new coupon named "(.*?)"$/) do |arg1|
#  find_by_id('new-coupon').click
#  fill_in 'coupon_stripe_id', with: arg1
#
#  find_by_id('commit-form').click
#  #sleep(4)
#  find('.table-responsive')
#  
#end