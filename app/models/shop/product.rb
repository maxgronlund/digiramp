class Shop::Product < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  
  validates :title, :body, :additional_info, presence: true
  
  #validates_numericality_of :price, greater_than: 49, message: "must be at least 50 cents"
                            
  validates_with ProductValidator
  mount_uploader :image,    ProductImageUploader
  
  CATEGORIES = ['Streaming', 'download', 'Service', 'Physical product', 'Coupon']
  
  before_save :populate_uuid
  
  #has_and_belongs_to_many :order_items, :class_name => "Shop::OrderItem"
  #has_and_belongs_to_many :orders, :class_name => "Shop::Order"
  has_many :shop_orders, through: :order_items, :class_name => "Shop::OrderItem"
  
  after_commit :flush_cache

  def self.cached_find(uuid)
    Rails.cache.fetch([name, uuid]) { find_by(uuid: uuid) }
  end
  
  

  private 
  

  
  def populate_uuid
    if new_record?
      self.uuid = UUIDTools::UUID.timestamp_create().to_s
    end
  end
  

  def flush_cache
    Rails.cache.delete([self.class.name, uuid])
  end
end
