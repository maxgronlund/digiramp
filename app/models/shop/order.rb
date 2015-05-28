class Shop::Order < ActiveRecord::Base
  
  has_paper_trail
  include AASM
  
  belongs_to :user
  belongs_to :stripe_customer
  belongs_to :coupon
  
  serialize :invoice_object, Hash
  #has_and_belongs_to_many :products, :class_name => "Shop::Product"
  #has_many :shop_products, through: :order_items, :class_name => "Shop::OrderItem"
  
  has_many :order_items, :class_name => "Shop::OrderItem"
  
  before_destroy :remove_order_items
  
  aasm column: 'state' do
    state :pending, initial: true
    state :processing
    state :finished
    state :errored
    
    event :process, after: :charge_card do
      transitions from: :pending, to: :processing
    end
    
    event :finish do
      transitions from: :processing, to: :finished
    end
    
    event :fail do
        transitions from: :processing, to: :errored
    end
  end
  
  def charge_card
    ap ' Order#charge_card'
    save!
    begin
      
      charge = Stripe::Charge.create( amount: self.total_price.to_i.to_s,
                                      currency: "usd",
                                      source: self.stripe_token,
                                      description: self.email,
                                    )
      
      
      #ap charge 
      
      balance = Stripe::BalanceTransaction.retrieve(charge.balance_transaction)
      ap '----------------- balance ----------------------------'
      ap balance
      ap '======================================================'

      self.update(charge_id: charge.id)

      
    rescue Stripe::StripeError => e
      self.update_attributes(error: e.message)
      self.fail!
    end
  end
  
  def merge_with_and_delete order
    order.order_items.to_a.each do |order_item|
      order_item.update(order_id: self.id)
    end
    order.destroy!
  end
  
  
  def total_price
    tp  = 0.0
    self.order_items.to_a.each do |shop_item|
      tp += shop_item.product.price * shop_item.quantity
    end
    tp
  end
  
  def items_count
    count = 0
    self.order_items.to_a.each do |shop_item|
      count += shop_item.quantity
    end
    count
  end
  
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  private 

    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end
  
  def remove_order_items
    self.order_items.destroy_all
  end
  
end
