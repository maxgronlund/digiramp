class Shop::Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  
  validates :title, :body, presence: true
  validates_presence_of :title, :on => :update
  validates_with ProductValidator
  
  CATEGORIES = ['Streaming', 'download', 'Service', 'Physical product', 'Coupon']
  
  has_and_belongs_to_many :order_items, :class_name => "Shop::OrderItem"
end
