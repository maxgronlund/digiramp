require_relative '../../ascap'

Given(/^the username "(.*?)"$/) do |username|
  @username = username
end

Given(/^the password "(.*?)"$/) do |password|
  @password = password
end

When(/^I open the ascap login page$/) do
  @browser = WebBrowser.open url: Ascap::Login.url
end

Then(/^I should see the login form$/) do
  raise unless @browser.text_field(:id, "login")    .exist?
  raise unless @browser.text_field(:id, "password") .exist?
  raise unless @browser.link(      :id, "buttonOK") .exist?
end

When(/^I login$/) do
  Ascap::Login browser: @browser, username: @username, password: @password
end

Then(/^I should be on the member dashboard$/) do
  raise "Can't find dashboard welcome message" unless @browser.text.include? "Welcome to ASCAP"
end

Then(/^I should see the login error message$/) do
  raise unless @browser.text.include? "Authentication failed"
end