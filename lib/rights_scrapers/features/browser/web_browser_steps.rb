require 'watir-webdriver'
require_relative '../../web_browser'
#
When(/^I open the browser (\w+)(?: with the url "([^"]*)")?$/) do |*args|
  browser, url = *args
  begin
    @browser = WebBrowser.open url: url
  rescue EOFError
    warn "Make sure the browser isn't already open"
    raise
  end
end

When(/^go to "([^"]*)"$/) do |url|
  @browser.goto url
end

Then(/^I should see the text: "(.*?)"$/) do |text|
  raise unless @browser.text.include?(text)
end

Then(/^the browser should close$/) do
  @browser.close
end