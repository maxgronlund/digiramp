

When(/^I go to the add content page$/) do
  find_by_id('add_content').click
end

Then(/^I can select to create a work from a recording$/) do
  find_by_id('upload_recording').click
end