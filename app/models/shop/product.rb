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
  has_many :order_items, :class_name => "Shop::OrderItem"
  
  def seller_info
    user.seller_info
  end
  
  after_commit :flush_cache

  def self.cached_find(uuid)
    Rails.cache.fetch([name, uuid]) { find_by(uuid: uuid) }
  end
  
  def exclusive_offer?
    #if self.category == 
    ! self.exclusive_offered_to_email.blank?
  end
  
  def add_productable type, id
    self.productable_type = type
    self.productable_type = type
  end
  
  
  def self.attach record, product_params = {}

    product = Shop::Product.create(  title:                         product_params[:title], 
                                     body:                          product_params[:body], 
                                     additional_info:               product_params[:additional_info], 
                                     price:                         product_params[:price],
                                     exclusive_offered_to_email:    product_params[:exclusive_offered_to_email],
                                     download_link:                 product_params[:download_link],
                                     user_id:                       product_params[:user_id],
                                     account_id:                    product_params[:account_id],
                                     units_on_stock:                product_params[:units_on_stock],
                                     for_sale:                      product_params[:for_sale],
                                     image:                         product_params[:image],
                                     productable_id:                record.id,      
                                     productable_type:              record.class.name      
                                     
                                  )

    
  end
  
  def stakeholders
    # populate with more here
    sh = []
    sh << {user_id: self.user_id, split: 1.0 , account_id: self.account_id }
  end
  
  def update_stock
    if self.units_on_stock 
      self.units_on_stock -= 1 
      save
    end
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
