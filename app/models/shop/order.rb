class Shop::Order < ActiveRecord::Base
  
  has_paper_trail
  include AASM
  
  belongs_to :user
  belongs_to :stripe_customer
  
  #has_and_belongs_to_many :products, :class_name => "Shop::Product"
  #has_many :shop_products, through: :order_items, :class_name => "Shop::OrderItem"
  
  has_many :order_items, :class_name => "Shop::OrderItem"
  
  before_destroy :remove_order_items
  
  aasm column: 'state' do
    state :shopping
    #state :processing
    state :process_payment
    state :payment_completed



    #event :process, before: :checkout do
    #  transitions from: :pending, to: :processing
    #end

    event :pay do
      transitions from: :shopping, to: :process_payment
    end
    
    event :paid do
      transitions from: :process_payment, to: :payment_completed
    end
    
    event :fail do
      transitions from: :process_payment, to: :shopping
    end
    
    
  end
  
  def checkout
    
    self.save
  end
  
  private
  
  def remove_order_items
    self.order_items.destroy_all
  end
  
end
