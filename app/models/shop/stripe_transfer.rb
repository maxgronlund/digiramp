class Shop::StripeTransfer < ActiveRecord::Base
  include ErrorNotification
  has_paper_trail
  
  belongs_to :order_item,    class_name: "Shop::OrderItem"
  belongs_to :order,         class_name: "Shop::Order"
  belongs_to :user
  belongs_to :account
  belongs_to :stake       
  
  
  
  include AASM
  

  def title
    self.order_item ? order_item.title : 'na'
  end
 
 
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
     transitions from: [:processing, :pending], to: :finished
   end

   event :fail do
     transitions from: :processing, to: :errored
   end
   
   event :reset do
     transitions from: [:errored, :processing], to: :pending
   end
 end
 
 def seller_account_id
   begin
     self.user.account.id
   rescue
     post_error "Shop::OrderItem id: #{self.id} account not found "
     User.system_user.account.id
   end
 end
 
 def pay
   ap '===================================================================================='
   ap '--- pay ---'
   self.process!
   
   begin
    Stripe::Transfer.create(
      amount:                 self.amount,
      destination:            self.user.stripe_id,
      source_transaction:     self.source_transaction,
      currency:               self.currency,
      description:            get_description,
      #metadata:               {'fees' => get_fees.to_s},
      statement_descriptor:   'DigiRAMP Payment',
      application_fee:        self.application_fee
    )
    self.finis!
   rescue Stripe::StripeError => e
     self.fail!
     self.stripe_errors = e.message
     errored('Shop::StripeTransfer#pay', e )
   end
   self.save
 end
 
 private 
 
 def get_description
   
   if order_item && product = order_item.shop_product
     self.description = order_item.quantity.to_s
     self.description << ' x '
     self.description << product.title
   else
    self.description = 'DigiRAMP Payment'
   end
   self.description
 end

 #def get_fees
 #  @fees || split_fees
 #end
 #
 #def split_fees
 #  @fees = 0
 #  begin
 #   @fees =  self.account.stripe_flat_transfer_fee
 #   @fees += self.amount.to_f * account.stripe_percent_transfer_fee
 #   @fees *= self.split
 # rescue => error
 #   errored('Shop::StripeTransfer#split_fees', e )
 # end
 # (@fees + 0.5).to_i
 #end
 

 #ap Stripe::Transfer.create(
 #  :amount => 400,
 #  :destination => stripe_account_id,
 #  :source_transaction => 'ch_16B0xCE9gjydUcHEWu1GG93s',
 #  :currency => "usd"
 #)
    
    

end
