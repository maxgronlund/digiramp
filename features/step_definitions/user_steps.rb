
Given(/^I am the administrator$/) do
  #user = FactoryGirl.create(:user, email: 'hansen@digiramp.com', password: 'adminadmin', role: 'Super')
  find_or_create_user(  'Super Controller', 'admin@digiramp.com', 'adminadmin', 'Super')
end

Given(/^I am logged in$/) do
  visit "/?landing_page=users"
  visit "/login/new"
  fill_in 'sessions_email', with: 'hansen@digiramp.com'
  fill_in 'sessions_password', with: 'adminadmin'
  find_by_id('log_in_form_button').click
  find('.all-users')
  #sleep(1)
end

Given(/^I'm logged in as "(.*?)" with the password "(.*?)"$/) do |email, password|
  visit "/login/new"
  fill_in 'sessions_email', with: email
  fill_in 'sessions_password', with: password
  find_by_id('log_in_form_button').click
  visit "/?landing_page=users"
  find('.all-users')
end

Given(/^I am logged in as administrator$/) do

  find_or_create_user(  'Super Controller', 'hansen@digiramp.com', 'adminadmin', 'Super')
  visit "/"
  visit "/login/new"
  fill_in 'sessions_email', with: 'hansen@digiramp.com'
  fill_in 'sessions_password', with: 'adminadmin'
  find_by_id('log_in_form_button').click
  visit "/?landing_page=users"
  find('.all-users')
end

Given(/^there is a user with the email "(.*?)" and the password "(.*?)"$/) do |email, password|
  #user = FactoryGirl.create(:user, email: email, password: password, role: 'Customer')
  find_or_create_user(  Faker::Name.first_name , email, password, 'Customer')
end

Given(/^the user with the email "(.*?)" has a recording with the name "(.*?)"$/) do |email, title|
  user = get_user email
  recording = find_or_create_recording(  user, title )
end

Given(/^there is a user with the name "(.*?)" email "(.*?)" and the password "(.*?)"$/) do |name, email, password|
  #user = FactoryGirl.create(:user, user_name: name, email: email, password: password, role: 'Customer')
  find_or_create_user(  name, email, password, 'Customer')
end

When(/^I visit the user "(.*?)"$/) do |name|
  if user = user_with_name( name )
    visit "/users/#{user.slug}"
  else 
    
  end
end

When(/^I visit a non existing recording page the user "(.*?)"$/) do |name|
  if user = user_with_name( name)
    visit "/users/#{user.slug}/recordings/45645"
  else
    
  end
end