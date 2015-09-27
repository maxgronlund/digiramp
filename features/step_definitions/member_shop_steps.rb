
When(/^I'm on the admin shop pages for the user with the email "(.*?)"$/) do |email|
  @user = user_with_email email
  visit "/user/users/#{@user.slug}/shop_admin"
end


Then(/^I fill the physical product form form with title: "(.*?)", price: "(.*?)", forsale: "(.*?)", show in public shop: "(.*?)", units in stock: "(.*?)", Info on badges, "(.*?)", Description: "(.*?)", delivery_time: "(.*?)", shipping_cost: "(.*?)",$/) do | title,  price, for_sale, show_in_public_shop, units_in_stock, info_on_badges, description, delivery_time, shipping_cost |
  
  fill_in 'shop_product_title', with: title
  fill_in 'shop_product_price', with: price
  #check('shop_product_for_sale')
  #check('shop_product_show_in_shop')
  fill_in 'shop_product_units_on_stock', with: units_in_stock
  fill_in 'shop_product_delivery_time', with: delivery_time
  fill_in 'shop_product_shipping_cost', with: shipping_cost
  fill_in 'shop_product_additional_info', with: info_on_badges
  fill_in 'wysihtml5_editor', with: description
  find_by_id('commit-form').click
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

