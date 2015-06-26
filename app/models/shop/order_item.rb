class Shop::OrderItem < ActiveRecord::Base
  belongs_to :order,    class_name: "Shop::Order"
  belongs_to :product,  class_name: "Shop::Product"
  has_many   :stripe_transfers, class_name: "Shop::StripeTransfer"
  
  validates_with OrderItemValidator

  def product
    Shop::Product.find_by(id: self.product_id)
  end

  after_commit :flush_cache

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  # transfer payment to all stakeholders
  # called when payments success
  def send_transfer_to_stakeholders( amount, stripe_charge_id)
    if product = self.product
      product.stakeholders.each do |stakeholder|
        send_transfer_to_stakeholder( stakeholder, amount, stripe_charge_id)
      end
    end
    self.sold = true
    self.save
  end
  
  def seller_info
    product.seller_info
  end

  private 
  
  # transfer to one stakeholder
  def send_transfer_to_stakeholder( stakeholder, amount, stripe_charge_id)
    # Don't make a transfer from an account to itself
    unless self.order.user_id == stakeholder[:user_id]
      Shop::StripeTransfer
        .where( 
                order_item_id:   self.id,
                order_id:        self.order_id, 
                user_id:         stakeholder[:user_id]
               )
        .first_or_create(
                order_item_id:      self.id,
                order_id:           self.order_id, 
                user_id:            stakeholder[:user_id], 
                account_id:         stakeholder[:account_id],
                split:              stakeholder[:split],
                amount:             (amount * stakeholder[:split]).to_i,
                source_transaction: stripe_charge_id,
                currency:           'usd'
               )
                    
    end
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
