Given(/^there is a product calles "(.*?)"$/) do |title|
  product = find_or_create_shop_product( title )
end