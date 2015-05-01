Given(/^there is a user with the email "(.*?)" and the password "(.*?)"$/) do |email, password|
  user = FactoryGirl.create(:user, email: email, password: password, role: 'Customer')
end

Given(/^the user with the email "(.*?)" has a recording with the name "(.*?)"$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end
