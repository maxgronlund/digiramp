Given(/^these account users is added to$/) do |customers_table|
  add_customers_to_account customers_table.raw
end

Then(/^I am creating a customer with the email "(.*?)" the name "(.*?)" and the phone "(.*?)"$/) do |email, name, phone|
  fill_in "account_user_email", with: email
  fill_in "account_user_name", with: name
  fill_in "account_user_phone", with: phone
  find_by_id('save_new_customer').click
end

