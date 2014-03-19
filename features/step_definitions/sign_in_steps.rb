When(/^I am logged in with the email "(.*?)" and the password "(.*?)"$/) do |email, password|
  visit "/login/new"
  fill_in "sessions_email", with: email
  fill_in "sessions_password", with: password
  find_by_id('log_in_form_button').click
end