class Shop::OrderItem < ActiveRecord::Base
  belongs_to :shop_order,    class_name: "Shop::Order"
  belongs_to :shop_product,  class_name: "Shop::Product"
  
  validates_with OrderItemValidator
  
  def product
    Shop::Product.find_by(id: self.product_id)
  end
  
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end


  private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
