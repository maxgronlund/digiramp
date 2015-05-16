class Shop::Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :stripe_customer
  
  has_and_belongs_to_many :products, :class_name => "Shop::OrderItem"
  
end
