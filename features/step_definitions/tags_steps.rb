Given(/^there is a genre named "(.*?)"$/) do |title|
  find_or_create_genre_tag( title)
end

Given(/^there is a mood named "(.*?)"$/) do |title|
  #mood = FactoryGirl.create(:mood, title: 'genre')
  find_or_create_mood_tag( title)
end

Given(/^there is an instrument named "(.*?)"$/) do |title|
  #instrument = FactoryGirl.create(:instrument, title: 'genre')
  find_or_create_instrument_tag( title)
end

When(/^I'm on the edit genre page for the "(.*?)" tag$/) do |title|
  visit "/admin/genres"
  find_by_id(title).click
  find('.edit_genre')
end

When(/^I'm on the edit instrument page for the "(.*?)" tag$/) do |title|
  visit "/admin/instruments"
  find_by_id(title).click
  find('.edit_instrument')
end

When(/^I'm on the edit mood page for the "(.*?)" tag$/) do |title|
  visit "/admin/moods"
  find_by_id(title).click
  find('.edit_mood')
end

#When(/^there is a blog named "(.*?)"$/) do |arg1|
#  blog = FactoryGirl.create(:blog, title: 'chunky beacon', 
#                                  body: 'yummy yummy', 
#                                  identifier: 'beacon', 
#                                  layout: 'cool')
#end
#
#When(/^there is a blog post named "(.*?)"$/) do |arg1|
#  blog_post = FactoryGirl.create(:blog_post, 
#                              title: 'chunky beacon', 
#                              body: 'yummy yummy', 
#                              image_title: 'bella vista', 
#                              identifier: 'beacon', 
#                              blog_id: 1,
#                              position: 0,
#                              link: 'http://google.com',
#                              teaser: 'yummy',
#                              layout: 'bright'
#                              )
#
#end