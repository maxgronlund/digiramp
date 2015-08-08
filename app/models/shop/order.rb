
class Shop::Order < ActiveRecord::Base
  
  has_paper_trail
  include AASM
  include ErrorNotification
  
  belongs_to :user
  #belongs_to :stripe_customer
  belongs_to :coupon
  
  serialize :invoice_object, Hash
  serialize :order_lines, Array
  serialize :order_content, Hash
  #has_and_belongs_to_many :products, :class_name => "Shop::Product"
  #has_many :shop_products, through: :order_items, :class_name => "Shop::OrderItem"
  
  
  has_many :order_items,      class_name: "Shop::OrderItem" ,    foreign_key: 'shop_order_id'
  has_many :stripe_transfers, class_name: "Shop::StripeTransfer"
  
  before_destroy :remove_order_items
  #after_save :save_addresses
  
  #has_many :addresses, as: :addressable, dependent: :destroy
  
  #validates :email, presence: true
  #validates_formatting_of :email
  
  
  aasm column: 'state' do
    state :pending, initial: true
    state :processing
    state :finished
    state :errored
    
    
    event :process, after: :charge_card do
      transitions from: :pending, to: :processing
    end
    
    event :finish, after: :store_order_lines do
      transitions from: :processing, to: :finished
    end
    
    event :fail do
        transitions from: :processing, to: :errored
    end
    
    event :reset do
        transitions from: [:pending, :errored, :processing, :finished], to: :pending
    end
    
  end
  
  def charge_card
    
    save!
    begin
      charge = Stripe::Charge.create( amount: self.total_price.to_i.to_s,
                                      currency: "usd",
                                      source: self.stripe_token,
                                      description: self.email,
                                      statement_descriptor: nil,
                                      shipping: {}
                                    )
      
      # charge 
      #balance = Stripe::BalanceTransaction.retrieve(charge.balance_transaction)
      # '----------------- balance ----------------------------'
      # balance
      # '======================================================'

      self.update(charge_id: charge.id)
      # '----------------- charge_id ----------------------------'
      # self.charge_id
      # '--------------------------------------------------------'
      
    rescue Stripe::StripeError => e
      self.update_attributes(error: e.message)
      self.fail!
      post_error "Order#charte_card: #{e.message}"
    end
  end
  
  def merge_with_and_delete old_shop_order
    
    old_shop_order.order_items.to_a.each do |order_item|
      new_order_item          = order_item.dup
      new_order_item.order_id = self.id
      new_order_item.save!

    end
    old_shop_order.destroy!
  end
  
  def buyer_account_id
    return nil unless self.user
    return nil unless self.user.account
    self.user.account.id
  end
  
  def units_of_product product_id
    cnt = 0
    if items = self.order_items.where(shop_product_id: product_id)
      items.each do |order_item|
        cnt += order_item.quantity
      end
    end
    cnt
  end
  
  
  def total_price
    tp  = 0.0

    self.order_items.each do |order_item|
      if product = order_item.shop_product
        tp += product.price * order_item.quantity
      end
    end
    tp
  end
  
  def invalid?
    OrderValidator.check_validity_on( self )
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
  
  def store_order_lines
    
    begin
    self.order_lines = []
    self.order_items.each_with_index do |order_item, index|
      if product = order_item.shop_product
        self.order_lines[index] = product.as_json.merge( "total_price" => (order_item.quantity * product.price),
                                                         "quantity" => order_item.quantity,
                                                         "shop_order_item_id" => order_item.id,
                                                         "seller_info"        => order_item.seller_info)
                                                         
                                                         
        product.update_stock
      end
    end
    save!
  rescue => e
    post_error "Order#store_order_lines #{e.message}"
  end
  end

  def require_shipping_address
    self.order_items.each do |order_item|
      if product = order_item.shop_product
        return true if product.category == "physical-product"
      end
    end
    false
  end
  
  def shipping_address
    Address.find_by(addressable_id: self.id, addressable_type: self.class.name)
  end

  def payment_source
    self.order_content[:payment_source]
  end
  
  def price_total
    self.order_content[:total_price]
  end
  
  # the order is paid for, time to pay the stakeholders
  def charge_succeeded stripe_charge_id, amount
    begin
      self.order_items.each do |order_item|
        order_item.charge_succeeded( amount, stripe_charge_id) 
      end
    rescue => error
      post_error "Order#create_transfers: #{error.inspect}"
    end
  end

  private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  def remove_order_items
    self.order_items.destroy_all
  end
  
end
