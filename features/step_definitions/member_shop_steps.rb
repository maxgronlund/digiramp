When(/^I'm on the admin shop pages for the user with the email "(.*?)"$/) do |email|
  @user = user_with_email email
  visit "/user/users/#{@user.slug}/shop_admin"
end

Then(/^I fill the physical product form form with title: "(.*?)", price: "(.*?)", forsale: "(.*?)", dimentions: "(.*?)", shipping cost: "(.*?)", units in stock: "(.*?)", waight: "(.*?)"$/) do |arg1, arg2, arg3, arg4, arg5, arg6, arg7|
  #pending # express the regexp above with the code you wish you had
end


When(/^I look at the product details for "(.*?)"$/) do |arg1|
  #pending # express the regexp above with the code you wish you had
end

When(/^I go to the public shop and select "(.*?)"$/) do |arg1|
  #pending # express the regexp above with the code you wish you had
end

Then(/^I fill the download product form form with title: "(.*?)", price: "(.*?)", forsale: "(.*?)", type: "(.*?)" and a license$/) do |arg1, arg2, arg3, arg4|
  #pending # express the regexp above with the code you wish you had
end

Then(/^I fill the service product form form with title: "(.*?)", price: "(.*?)", forsale: "(.*?)", type: "(.*?)"$/) do |arg1, arg2, arg3, arg4|
  #pending # express the regexp above with the code you wish you had
end

When(/^I go the shop for "(.*?)"$/) do |arg1|
  #pending # express the regexp above with the code you wish you had
end

