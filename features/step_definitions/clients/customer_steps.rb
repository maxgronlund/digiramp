Then(/^I can crate a customer named "(.*?)" with email "(.*?)" and phone "(.*?)"$/) do |name, email, phone|
  find_by_id('new_customer').click
  fill_in "account_user_name", with: name
  fill_in "account_user_email", with: email
  fill_in "account_user_phone", with: phone
  find_by_id('save_new_customer').click
  
end