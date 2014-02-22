Then(/^I can fill in the sign up form$/) do

  
  fill_in "user_email", with: "john@little.com"
  fill_in "user_password", with: "pasword"
  fill_in "user_password_confirmation", with: "pasword"
  
  
  
end

Then(/^click on the Sign Up button$/) do
  find_by_id('sign_up_form_button').click
end
