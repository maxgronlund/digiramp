class Shop::OrderItem < ActiveRecord::Base
  include ErrorNotification
  default_scope -> { order('created_at ASC') }
  
  belongs_to :shop_order,    class_name: "Shop::Order"
  belongs_to :shop_product,  class_name: "Shop::Product"
  has_many   :stripe_transfers, class_name: "Shop::StripeTransfer"
  
  validates_with OrderItemValidator
  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  # transfer payment to all stakeholders
  # called when payments success
  def charge_succeeded params

    begin
      self.update(sold: true)
      
      params[:order_item_id] = self.id
      product                = self.shop_product
      
      product.stakeholders.each  do |stake|
        stake.charge_succeeded params
      end

    rescue => e
      post_error "OrderItem#charge_succeeded: #{e.inspect}"
    end
  end

  def description
    return shop_product.additional_info if shop_product
    'na'
  end
    
  

  
  #def payment_fee_pr_stakeholder stakeholders, payment_fee_pr_order_item
  #  # what it the fee pr item
  #  split_between = 1
  #  
  #  split_between = stakeholders.count unless stakeholders.count
  #  begin
  #    split_between = stakeholders.count ? stakeholders.count.to_f : 1.0
  #    payment_fee_pr_order_item / split_between
  #  rescue => error
  #    post_error "OrderItem#payment_fee_pr_stakeholder: #{error.inspect}"
  #  end
  #end
  
  def seller_info
    seller = self.shop_product.seller_info
    if seller[:id] == 'error'
      post_error "Shop::OrderItem id: #{self.id} is not for sale "
    end
    seller
  end
  
  def seller_account_id
    begin
      self.shop_product.account_id
    rescue
      post_error "Shop::OrderItem id: #{self.id} seller_account_id not found "
      User.system_user.account.id
    end
  end
  
  def buyer_account_id
    begin
      self.shop_order.buyer_account_id
    rescue => e
      post_error "Shop::OrderItem id: #{self.id} buyer_account_id not found "
      User.system_user.account.id
    end
  end
  
  def download_url
    self.shop_product.download_url
  end
  
  def additional_download_url
    self.shop_product.additional_download_url
  end
  
  def last
    Shop::OrderItem.order(:created_at).last
  end
  
  def first
    Shop::OrderItem.order(:created_at).first
  end
  
  def title
    self.shop_product ? self.shop_product.product_title : 'na'
  end

  private 
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
