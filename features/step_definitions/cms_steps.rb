When(/^I'm on the admin cms pages for the user with the email "(.*?)"$/) do |email|
  user = user_with_email email
  visit "/user/users/#{user.slug}/cms_pages"
end

Then(/^I fill in the new cms page form and save$/) do
  fill_in 'cms_page_title', with: 'About me'
  find_by_id('save-cms-page').click
end