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
  def charge_succeeded( amount, stripe_charge_id, payment_fee_pr_order_item)
    
    
    begin
      if product      = self.shop_product
        if stakeholders = product.stakeholders
          
          # how many is there to pay for the payment fee
          payment_fee_slices = product.stakeholders.count
          
          if master_ipis = stakeholders.where(ip_type: ['Ipi', 'PublishingAgreement'])
            pay_master_royalty( master_ipis, amount, stripe_charge_id )
            # ips should always get a fixed amount so they 
            # can't take part in paying the transaction fees
            payment_fee_slices -= master_ipis.count
          end
          
          payment_fee =  payment_fee_pr_order_item.to_f / payment_fee_slices.to_f
          ap "payment_fee pr non ipi stakeholder: #{payment_fee}"
          
          product.stakeholders.where.not(ip_type: 'Ipi').each do |stakeholder|
            stakeholder.charge_succeeded( self.id,  amount, stripe_charge_id, payment_fee )
          end
        else
          post_error "OrderItem#charge_succeeded: shop_product_id #{self.shop_product_id} stakeholders not found"
        end
      else
        post_error "OrderItem#charge_succeeded: shop_product_id #{self.shop_product_id} not found"
      end
      self.sold = true
      self.save
    
    
    
    rescue => error
      post_error "OrderItem#charge_succeeded: #{error.inspect}"
    end
  end
  
  #pay master royalty, no fee
  def pay_master_royalty master_ipis, amount, stripe_charge_id
    master_ipis.each do |stakeholder|
      stakeholder.charge_succeeded( self.id,  amount, stripe_charge_id, 0.0 )
    end
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
    rescue
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
