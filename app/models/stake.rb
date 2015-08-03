# is attached to an shop item
class Stake < ActiveRecord::Base
  belongs_to :account
  belongs_to :asset, polymorphic: true

  has_paper_trail
  include ErrorNotification
  
  validates :email, :split, presence: true
  validates_formatting_of :email, :using => :email, :allow_nil => false
  validates_with StakeValidator
  
  after_create :set_relations
  before_destroy :remove_streams
  
  has_many :stripe_transfers, class_name: Shop::StripeTransfer

  after_commit :flush_cache
  
 
  
  def generated_income
    unit_price * units_sold
  end
  
  def units_sold
    @units_sold ||= stripe_transfers.count
  end
  
  def title
    self.asset ? self.asset.title : 'na'
  end
  
  def unit_price
    @price ||= calculate_unit_price
  end
  
  def stakeholders
    Stake.where(asset_type: self.class.name, asset_id: self.id)
  end
  

  def charge_succeeded order_item_id, amount, stripe_charge_id
    
    # take the cut
    take_a_cut order_item_id, amount, stripe_charge_id
    
    # let other get their cut
    let_other_get_their_cut order_item_id, amount, stripe_charge_id

  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  private 
  
  def calculate_unit_price
    price = 0.0
    case self.asset_type
    when 'Shop::Product'
      price = asset.price.to_f * 0.0001 * self.split
    when 'Stake'
      stake = Stake.cached_find(self.asset_id)
      price = stake.unit_price * stake.split * 0.0001
    end
    price
  end
  
  def set_relations
    if new_record?
      self.original_source = self.income_source
      save
    end
    attach_to_user
  end
  
  def let_other_get_their_cut order_item_id, amount, stripe_charge_id

    self.stakeholders.each do |stakeholder|
      stakeholder.charge_succeeded order_item_id, amount, stripe_charge_id
    end
  end
  
  # create a stripe transfer 
  def take_a_cut order_item_id, amount, stripe_charge_id
    
    begin
      order_item      = Shop::OrderItem.cached_find( order_item_id )
      amount          = (amount.to_f * self.split * 0.01)
      application_fee = (amount * 0.019) + 0.5

      # tripy way to prevent the same transfer to run two times
      stripe_transfer = Shop::StripeTransfer
          .where( shop_order_id:        order_item.shop_order_id,
                  shop_order_item_id:   order_item_id, 
                  account_id:           self.account_id,
                  user_id:              self.account.user_id,
                  source_transaction:   stripe_charge_id,
                  stake_id:             self.id
                 )
          .first_or_create( shop_order_id:        order_item.shop_order_id,
                            shop_order_item_id:   order_item_id, 
                            account_id:           self.account_id,
                            user_id:              self.account.user_id,
                            source_transaction:   stripe_charge_id,
                            split:                self.split,
                            amount:               amount.to_i,
                            currency:             'usd',
                            stake_id:             self.id,
                            application_fee:      application_fee.to_i
                           )
      
      # stripe_transfer
      # '=============================================='
      # order_item
      # '=============================================='
      # mark as paid if the money already is on the right account
      stripe_transfer.finis! if stripe_transfer.seller_account_id == order_item.seller_account_id

    rescue => e
      errored('Stake#transfer_to_stripe', e )
    end         
  end
  private
    
    

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end 
  
  def remove_streams
    self.stakeholders.destroy_all if self.stakeholders
  end
  
  def attach_to_user
    self.channel_uuid = UUIDTools::UUID.timestamp_create().to_s

    if user = User.find_by(email: self.email)
    elsif user_email = UserEmail.find_by(email: self.email)
      user = user_email.user
    end

    if user
      self.account_id   = user.account.id
      elsewel
      self.unassigned   = false
    end 
    self.save!
  end
  
  
  
end
