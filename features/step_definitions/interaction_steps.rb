require 'test/unit'
include Test::Unit::Assertions

When(/^I click on the button "(.*?)"$/) do | button|
  click_button button
end

When(/^I click on the link "(.*?)"$/) do |link|
  click_on link
end

Then(/^I select "(.*?)" from "(.*?)"$/) do |select, from|
  select select, :from => from
end

Then(/^I'm filling "(.*?)" with "(.*?)"$/) do |placeholder, content|
  fill_in placeholder, with: content
end


Then(/^I'm filling the "(.*?)" in the ckeditor with "(.*?)"$/) do |input_id, content|
  browser = page.driver.browser
  browser.execute_script("CKEDITOR.instances['#{input_id}'].setData('#{content}');")
end


Then(/^Does it look right\?$/) do
  ask('does that look right?')
end

Then(/^I'm enabling the checkbox "(.*?)"$/) do |checkbox|
  check(checkbox)
end

Then(/^I'm disabling the checkbox "(.*?)"$/) do |checkbox|
  uncheck(checkbox)
end


Then(/^I'm attaching the file "(.*?)" to "(.*?)"$/) do |file_name, image_field|
  attach_file(image_field, File.join(Rails.root, "/features/files/#{file_name}"))
end

Then(/^I click on a link with id "(.*?)"$/) do |id|
  find_by_id(id).click
end



Then(/^I select "(.*?)" from the "(.*?)" dropdown$/) do |select, from|
  select select, :from => from
end

Then(/^I click delete on the link with the id "(.*?)"$/) do |link_id|
  id = "delete_#{link_id.downcase.tr!(" ", "_")}"
  find_by_id(id).click
end

Then /^I confirm popup$/ do
  page.driver.browser.switch_to.alert.accept    
end

Then /^I dismiss popup$/ do
  page.driver.browser.switch_to.alert.dismiss
end

Then /^I wait for (\d+) seconds?$/ do |n|
  sleep(n.to_i)
end

Then(/^I click on "(.*?)" for  "(.*?)"$/) do |prefix, link_id|
  
  id = "#{prefix.downcase.tr!(" ", "_")}_#{link_id.downcase.tr!(" ", "_")}"
  find_by_id(id).click
end






#attach_file('article_image', File.join(Rails.root, '/spec/support/example.jpg'))
#attach_file(‘asset_file’,”#{Rails.root}/spec/fixtures/images/image1.png”)\

