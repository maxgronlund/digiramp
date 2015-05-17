class Shop::Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  
  validates :title, :body, presence: true
  validates_presence_of :title, :on => :update
  validates_with ProductValidator
  
  CATEGORIES = ['Streaming', 'download', 'Service', 'Physical product', 'Coupon']
  
  #has_and_belongs_to_many :order_items, :class_name => "Shop::OrderItem"
  #has_and_belongs_to_many :orders, :class_name => "Shop::Order"
  has_many :shop_orders, through: :order_items, :class_name => "Shop::OrderItem"
  
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
