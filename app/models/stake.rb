class Stake < ActiveRecord::Base
  belongs_to :account
  belongs_to :asset, polymorphic: true
  has_paper_trail
  
  validates :email, :split, presence: true
  validates_formatting_of :email, :using => :email, :allow_nil => false
  
  after_create :attach_to_user
  before_destroy :remove_streams

  after_commit :flush_cache
  


  
  def income_source
    title = 'na'
    case self.asset_type
      
    when 'Shop::Product'
      shop_product = Shop::Product.find_by(id: self.asset_id)
      case shop_product.productable_type
      when 'Recording'
        recording = Recording.cached_find(shop_product.productable_id)
        title = "Recording:#{recording.title}"
      end
      
    end
    title
  end
  
  def stakeholders
    Stake.where(asset_type: self.class.name, asset_id: self.id)
  end
  
  # create a stripe transfer 
  def transfer_to_stripe order_item_id, amount, stripe_charge_id
    order_item = Shop::OrderItem.cached_find( order_item_id )
    
    # tripy way to prevent the same transfer to run two times
    Shop::StripeTransfer
        .where( 
                order_item_id:   self.id,
                order_id:        self.order_id, 
                user_id:         stakeholder[:user_id]
               )
        .first_or_create(
                    
                      order_item_id:      order_item_id,
                      order_id:           order_item.order_id, 
                      user_id:            stakeholder[:user_id], 
                      account_id:         stakeholder[:account_id],
                      split:              stakeholder[:split],
                      amount:             (amount * stakeholder[:split]).to_i,
                      source_transaction: stripe_charge_id,
                      currency:           'usd'
                     )
             
  end

  def charge_succeeded order_item_id, amount, stripe_charge_id
    
    
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  private 

    def flush_cache
      Rails.cache.delete([self.class.name, id])
    end 
    
    def remove_streams
      self.stakeholders.destroy_all
    end
  
    def attach_to_user
      self.channel_uuid = UUIDTools::UUID.timestamp_create().to_s

      if user = User.find_by(email: self.email)
      elsif user_email = UserEmail.find_by(email: self.email)
        user = user_email.user
      end

      if user
        self.account_id   = user.account.id
      else
        self.unassigned   = false
      end 
      self.save!
  end
  
  
  
end
