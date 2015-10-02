When(/^I'm on the admin cms pages for the user with the email "(.*?)"$/) do |email|
  user = user_with_email email
  visit "/user/users/#{user.slug}/cms_pages"
end

Then(/^I fill in the new cms page form and save$/) do
  
  fill_in 'cms_page_title', with: 'About me'
  select 'Alabama', :from => 'cms_page_layout'
  select 'Default', :from => 'cms_page_theme'
  find_by_id('save-cms-page').click
end

Then(/^I select the banner module and click on next$/) do
  select 'Banner', :from => 'cms_section_cms_type'
  find_by_id('next').click
end

Then(/^I fill in the edit banner form and save$/) do
  fill_in 'cms_banner_title', with: 'Chunky beacon'
  find_by_id('save').click
end

Then(/^I edit the banner$/) do
  find_by_id('edit-cms-banner').click
  fill_in 'cms_banner_title', with: 'Hello world'
  find_by_id('save').click
end

Then(/^I remove the banner$/) do
  find_by_id('remove-cms-banner').click
  page.driver.browser.switch_to.alert.accept
end