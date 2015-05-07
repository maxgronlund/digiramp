Given(/^there is a user with the email "(.*?)" and the password "(.*?)"$/) do |email, password|
  #user = FactoryGirl.create(:user, email: email, password: password, role: 'Customer')
  find_or_create_user(  'Member Joe', email, password, 'Customer')
end

Given(/^the user with the email "(.*?)" has a recording with the name "(.*?)"$/) do |email, arg2|
  user = user_with_email email
  
  #pending # express the regexp above with the code you wish you had
end
