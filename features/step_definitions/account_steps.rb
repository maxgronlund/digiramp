Then(/^I can fill in the account info$/) do
  fill_in "account_contact_first_name", with: "John"
  fill_in "account_contact_last_name", with: "Smith"
  fill_in "account_contact_email", with: "max@digiramp.org"
  fill_in "account_fax", with: "500 123 456"
  fill_in "account_country", with: "US"
  fill_in "account_street_address", with: "Burbank Bulleward"
  fill_in "account_city", with: "Los Angeles"
  fill_in "account_state", with: "Calefornia"
  fill_in "account_postal_code", with: "500600"
  
  
end

Given(/^"(.*?)" is prepared and the account owner name is "(.*?)" with the email "(.*?)" and the password "(.*?)" and the role "(.*?)"$/) do |title, name, email, password, role|
   create_account( title, name, email, password, role)
end

Given(/^these account users is added as associate to$/) do |associate_users_table|
   create_associate_users associate_users_table.raw
end