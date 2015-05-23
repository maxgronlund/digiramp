
Given(/^I am the administrator$/) do
  user = FactoryGirl.create(:user, email: 'admin@digiramp.com', password: 'adminadmin', role: 'Super')
end

Given(/^I am logged in$/) do
  visit "/"
  visit "/login/new"
  fill_in 'sessions_email', with: 'admin@digiramp.com'
  fill_in 'sessions_password', with: 'adminadmin'
  find_by_id('log_in_form_button').click
  find('.all-users')
  #sleep(1)
end

Given(/^I am logged in as administrator$/) do
  #user = FactoryGirl.create(:user, email: 'admin@digiramp.com', password: 'adminadmin', role: 'Super')
  find_or_create_user(  'Admin', 'admin@digiramp.com', 'adminadmin', 'Super')
  visit "/"
  visit "/login/new"
  fill_in 'sessions_email', with: 'admin@digiramp.com'
  fill_in 'sessions_password', with: 'adminadmin'
  find_by_id('log_in_form_button').click
  find('.all-users')
end

Given(/^there is a user with the email "(.*?)" and the password "(.*?)"$/) do |email, password|
  #user = FactoryGirl.create(:user, email: email, password: password, role: 'Customer')
  find_or_create_user(  'Member Joe', email, password, 'Customer')
end

Given(/^the user with the email "(.*?)" has a recording with the name "(.*?)"$/) do |email, title|
  user = get_user email
  recording = find_or_create_recording(  user, title )
end
