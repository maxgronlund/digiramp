# This class holds one item on an order. 
# Each item can belongs to many stakeholders
# The order_item keeps track of payments and state

class Shop::OrderItem < ActiveRecord::Base
  include ErrorNotification
  default_scope -> { order('created_at ASC') }
  
  belongs_to :shop_order,            class_name: "Shop::Order"
  belongs_to :shop_product,          class_name: "Shop::Product"
  has_many   :stripe_transfers,      class_name: "Shop::StripeTransfer"
  has_many   :recording_downloads,   class_name: "RecordingDownload"
  
  validates_with OrderItemValidator
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  # When the order is paid for
  # then it's time pass the payment on to
  # all stakeholders
  def charge_succeeded params
    ap params
    Notifyer.print( 'Shop::OrderItem#charge_succeeded' , params: params ) if Rails.env.development?
    

    begin
      self.update(sold: true)
      params[:order_item_id] = self.id
      self.shop_product.charge_succeeded( params )
    
    rescue => e
      post_error "OrderItem#charge_succeeded: #{e.inspect}"
    end
  end

  # Get additional info about the product
  def description
    return shop_product.additional_info if shop_product
    'na'
  end

  # Get info about the seller
  def seller_info
    _seller_info = self.shop_product.seller_info
    if _seller_info[:id] == 'error'
      post_error "Shop::OrderItem id: #{self.id} is not for sale "
    end
    _seller_info
  end
  
  # Get the sellers account_id
  def seller_account_id
    begin
      self.shop_product.account_id
    rescue
      post_error "Shop::OrderItem id: #{self.id} seller_account_id not found "
      User.system_user.account.id
    end
  end
  
  # Get the buyers account_id
  def buyer_account_id
    begin
      self.shop_order.buyer_account_id
    rescue => e
      post_error "Shop::OrderItem id: #{self.id} buyer_account_id not found "
      User.system_user.account.id
    end
  end
  
  # Get download url
  def download_url
    self.shop_product.download_url
  end
  
  # Get url to additional content
  def additional_download_url
    self.shop_product.additional_download_url
  end
  
  # Get product title
  def title
    self.shop_product ? self.shop_product.product_title : 'na'
  end

  private 
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
