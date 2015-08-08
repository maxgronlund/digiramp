class Shop::StripeTransfer < ActiveRecord::Base
  include ErrorNotification
  has_paper_trail
  
  belongs_to :order_item,    class_name: "Shop::OrderItem", foreign_key: "shop_order_item_id"
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
     transitions from: [:errored, :processing, :finished], to: :pending
   end
 end
 
 def seller_account_id
   begin
     self.order_item.seller_account_id
     #self.user.account.id
   rescue
     post_error "Shop::OrderItem id: #{self.id} account not found "
     User.system_user.account.id
   end
 end
 
 def pay
   # '===================================================================================='
   # '--- pay ---'
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
     self.description << product.product_title
   else
    self.description = 'DigiRAMP Payment'
   end
   self.description
 end


    

end
