Given(/^there user with the email "(.*?)" is an account user on the account for the user with the email "(.*?)"$/) do | account_user_email, account_email |
  
  account_owner = User.find_by(email: account_email)
  user          = User.find_by(email: account_user_email)
  
  @account_user  = find_or_create_account_user(account_owner.account_id, user.id)
  @account_user.grand_all_permissions

  
end

When(/^I'm on the account page for user with the email "(.*?)"$/) do |email|
  @user          = User.find_by(email: email)
  visit "/account/accounts/#{@user.account_id}"
end


When(/^I'm on the recordings page for user with the email "(.*?)"$/) do |email|
  @user          = User.find_by(email: email)
  visit "/account/accounts/#{@user.account_id}/recordings"
end

When(/^I'm on the opportunities page for user with the email "(.*?)"$/) do |email|
  @user          = User.find_by(email: email)
  visit "/account/accounts/#{@user.account_id}/opportunities"
end

When(/^I'm on the users page for user with the email "(.*?)"$/) do |email|
  @user          = User.find_by(email: email)
  visit "/account/accounts/#{@user.account_id}/account_users"
end

When(/^I'm on the works page for user with the email "(.*?)"$/) do |email|
  @user          = User.find_by(email: email)
  visit "/account/accounts/#{@user.account_id}/common_works"
end

When(/^I'm on the catalogs page for user with the email "(.*?)"$/) do |email|
  @user          = User.find_by(email: email)
  visit "/account/accounts/#{@user.account_id}/catalogs"
end

When(/^I'm on the CRM page for user with the email "(.*?)"$/) do |email|
  @user          = User.find_by(email: email)
  visit "/account/accounts/#{@user.account_id}/crm/index"
end

When(/^I'm on the IPI codes page for user with the email "(.*?)"$/) do |email|
  @user          = User.find_by(email: email)
  visit "/account/accounts/#{@user.account_id}/account_ipis"
end

When(/^I'm on the documents page for user with the email "(.*?)"$/) do |email|
  @user          = User.find_by(email: email)
  visit "/account/accounts/#{@user.account_id}/documents"
end