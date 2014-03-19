When(/^I visit the digiramp home page$/) do
  
   visit "/"
end

When(/^I am on the MANAGE CUSTOMERS page for "(.*?)"$/) do |account_title|
  
  account = Account.where(title: account_title).first
  visit "/accounts/#{account.id}/customers"
  
end

When(/^I go the the backend accounts page$/) do
  visit "/admin/accounts"
end

When(/^I go the the backend users page$/) do
   visit "/admin/users"
end

When(/^I go to the account "(.*?)"$/) do |title|
  account = Account.where(title: title).first
  visit "/accounts/#{account.id}"
end

