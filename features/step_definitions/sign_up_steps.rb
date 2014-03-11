Then(/^I can fill in the sign up form$/) do

  
  fill_in "user_email", with: "john@little.com"
  fill_in "user_password", with: "pasword"
  fill_in "user_password_confirmation", with: "pasword"
  
  
  
end

Then(/^click on the Sign Up button$/) do
  find_by_id('sign_up_form_button').click
end


Then(/^Im filling in the account name with Johns Music$/) do
  fill_in "account_title", with: "Johns Fine Music"
end

Then(/^Im filling in the user name with John Smith$/) do
  fill_in "user_name", with: "John Smith"
end
