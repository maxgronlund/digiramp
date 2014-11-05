#require 'test/unit'
#include Test::Unit::Assertions

#Given(/^I can see "(.*?)"$/) do |content|
#  #page.should have_content(content)
#  assert true
#end

Then(/^I can see "(.*?)"$/) do |content|
  page.should have_content(content)
end

Then(/^I can not see "(.*?)"$/) do |content|
  #assert page.has_content?(content), "#{content} is still visible"
  page.should_not have_content(content)
end

Then(/^I can see value "(.*?)" on the field "(.*?)"$/) do |value, field|
  find_field(field).value.should eq value
end

Then(/^If field "(.*?)" exists on the view I can see the value "(.*?)" on the field$/) do |field, value|
  if page.has_css? ("#"+field)
    find_field(field).value.should eq value
  end
end

Then(/^the checkbox "(.*?)" is enabled$/) do |check_box|
  assert_equal(has_checked_field?(check_box), true, 'checkbox not found or checked')
end

Then(/^the menu has the color "(.*?)"$/) do |id|
  page.should have_css("div#color_#{id}")
end