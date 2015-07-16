
When(/^I fill in the new template for a legal document form with the name "(.*?)" and save$/) do |title|
  
  select 'Recording', :from => 'document_tag'
  fill_in 'document_body', with: 'Personal recording license'
  fill_in 'document_title', with: title
  
  #browser = page.driver.browser
  #browser.execute_script("wysihtml5_editor.setValue('hi dude')")
  
  find_by_id('commit-form').click
end

When(/^I update the new template for a legal document form with the name "(.*?)" and save$/) do |title|
  fill_in 'document_title', with: title
  find_by_id('commit-form').click
end