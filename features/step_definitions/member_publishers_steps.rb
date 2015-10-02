When(/^I'm on the publishers pages for the user with the email "(.*?)"$/) do |email|
  user = user_with_email email
  visit "/user/users/#{user.slug}/publishers"
end

Then(/^I fill in the new publisher form and save$/) do
  fill_in 'publisher_email', with: 'publisher@digiramp.com'
  fill_in 'publisher_legal_name', with: 'DigiRAMP Publishing'
  find_by_id('save').click
end

Then(/^I fill in the edit publisher form and save$/) do
  fill_in 'publisher_address_attributes_address_line_1', with: 'Publishing street 1'
  fill_in 'publisher_address_attributes_address_line_2', with: 'Main building'
  fill_in 'publisher_address_attributes_city', with: 'Capitola'
  fill_in 'publisher_address_attributes_zip_code', with: '9600'
  fill_in 'publisher_address_attributes_country', with: 'US'
  fill_in 'publisher_address_attributes_state', with: 'CA'
  fill_in 'publisher_phone_number', with: '1 (300) 565 458'
  fill_in 'publisher_ipi_code', with: 'I-000000229-7'
  find_by_id('save').click
end

Then(/^I edit the publisher$/) do
  publisher = Publisher.last
  find_by_id("edit-publisher-#{publisher.id}").click
  fill_in 'publisher_legal_name', with: 'Gold publising by DigiRAMP'
  find_by_id('save').click
end

#Then(/^I select the banner module and click on next$/) do
#  select 'Banner', :from => 'cms_section_cms_type'
#  find_by_id('next').click
#end
#
#Then(/^I fill in the edit banner form and save$/) do
#  fill_in 'cms_banner_title', with: 'Chunky beacon'
#  find_by_id('save').click
#end
#
#Then(/^I edit the banner$/) do
#  find_by_id('edit-cms-banner').click
#  fill_in 'cms_banner_title', with: 'Hello world'
#  find_by_id('save').click
#end
#
#Then(/^I remove the banner$/) do
#  find_by_id('remove-cms-banner').click
#  page.driver.browser.switch_to.alert.accept
#end