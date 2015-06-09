class Shop::StripeTransfer < ActiveRecord::Base
  belongs_to :shop_order_item,    class_name: "Shop::OrderItem"
  belongs_to :shop_order,         class_name: "Shop::Order"
  belongs_to :user
  
  
  def pay #user_id
    #stakeholder = User.cached_find(user_id)
    stakeholder = User.last
    
    stripe_account_id = stakeholder.stripe_id
    #ap stripe_account_id
    
    #ap Stripe::Account.retrieve(stripe_account_id)
    
    #ap Stripe::Account.all(:limit => 3)
    #ap Stripe::Transfer.create(
    #  :amount => 400,
    #  :currency => "usd",
    #  :description => stripe_account_id
    #  #:recipient => "rp_16B88MDCWuUtTcRTnnUfHxzO",
    #)
    
    ap Stripe::Transfer.create(
      :amount => 400,
      :destination => stripe_account_id,
      :source_transaction => 'ch_16B0xCE9gjydUcHEWu1GG93s',
      :currency => "usd"
    )
    
  end
end
