Given(/^there is a product called "(.*?)"$/) do |title|
  product = find_or_create_shop_product( title )
end