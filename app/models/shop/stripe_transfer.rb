class Shop::StripeTransfer < ActiveRecord::Base
  belongs_to :order_item,    class_name: "Shop::OrderItem"
  belongs_to :order,         class_name: "Shop::Order"
  belongs_to :user
  belongs_to :account
  
  
  has_paper_trail
  include AASM
  

 #stakeholder = User.cached_find(user_id)
 #stakeholder = User.last
 #
 #stripe_account_id = stakeholder.stripe_id
 
 
 #aasm column: 'state', whiny_transitions: false do
 aasm column: 'state' do
   state :pending, initial: true
   state :processing
   state :finished
   state :errored

   event :process do
     transitions from: :pending, to: :processing
   end

   event :finis do
     transitions from: :processing, to: :finished
   end

   event :fail do
     transitions from: :processing, to: :errored
   end
   
   event :reset do
     transitions from: [:errored, :processing], to: :pending
   end

 end
 
 def pay
  self.process!
  
 
  
  begin
   Stripe::Transfer.create(
     amount:                 (self.amount - get_fees).to_i,
     destination:            self.user.stripe_id,
     source_transaction:     self.source_transaction,
     currency:               self.currency,
     description:            get_description,
     metadata:               {'fees' => get_fees.to_s},
     statement_descriptor:   'DigiRAMP Payment'
   )
   self.finis!
  rescue Stripe::StripeError => e
    self.fail!
    self.stripe_errors = e.message
    Opbeat.capture_message("StripeTransfer #{e.message}")
    ap e.message
  end
  self.save
 end
 
 private 
 
 def get_description
   
   if product = order_item.shop_product
     self.description = order_item.quantity.to_s
     self.description << ' x '
     self.description << product.title
   else
    self.description = 'DigiRAMP Payment'
   end
   self.description
 end

 def get_fees
   @fees || split_fees
 end
 
 def split_fees
   @fees = 0
   begin
    @fees =  self.account.stripe_flat_transfer_fee
    @fees += self.amount.to_f * account.stripe_percent_transfer_fee
    @fees *= self.split
  rescue => error
    Opbeat.capture_message("StripeTransfer #{error.inspect}")
    ap error.inspect
  end
  (@fees + 0.5).to_i
 end
 

 #ap Stripe::Transfer.create(
 #  :amount => 400,
 #  :destination => stripe_account_id,
 #  :source_transaction => 'ch_16B0xCE9gjydUcHEWu1GG93s',
 #  :currency => "usd"
 #)
    
    

end
