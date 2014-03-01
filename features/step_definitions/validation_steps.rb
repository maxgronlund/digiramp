require 'test/unit'
include Test::Unit::Assertions

Given(/^I can see "(.*?)"$/) do |content|
  page.should have_content(content)
  #ask('does that look right?') if content == ""
end

Then(/^I can not see "(.*?)"$/) do |content|
  #assert page.has_content?(content), "#{content} is still visible"
  page.should_not have_content(content)
end

Then(/^I can see value "(.*?)" on the field "(.*?)"$/) do |value, field|
  find_field(field).value.should eq value
end

Then(/^the checkbox "(.*?)" is enabled$/) do |check_box|
  assert_equal(has_checked_field?(check_box), true, 'checkbox not found or checked') 
end

