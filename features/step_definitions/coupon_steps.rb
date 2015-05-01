Then(/^I create a new coupon named "(.*?)"$/) do |arg1|
  find_by_id('new-coupon').click
  fill_in 'coupon_stripe_id', with: arg1

  find_by_id('commit-form').click
  #sleep(4)
  find('.table-responsive')
  
end