Then(/^I can fill in the account info$/) do
  fill_in "account_contact_first_name", with: "John"
  fill_in "account_contact_last_name", with: "Smith"
  fill_in "account_contact_email", with: "info@johnsmit.com"
  fill_in "account_fax", with: "500 123 456"
  fill_in "account_country", with: "US"
  fill_in "account_street_address", with: "Burbank Bulleward"
  fill_in "account_city", with: "Los Angeles"
  fill_in "account_state", with: "Calefornia"
  fill_in "account_postal_code", with: "500600"
  
  
end