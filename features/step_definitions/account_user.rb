Given(/^there user with the email "(.*?)" is an account user on the account for the user with the email "(.*?)"$/) do |account_email, account_user_email|
  
  account_owner = User.find_by(email: account_email)
  user          = User.find_by(email: account_user_email)
  
  account_user  = AccountUser.create(account_id: account_owner.account_id, user_id: user.id)
  account_user.grand_all_permissions
  
end