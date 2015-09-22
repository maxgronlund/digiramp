# a stake defines a split of a transaction 
# a stake comes from a source 
# - a recording
# - a a shop item
#
# a stake belongs to an account to where the money goes
# a stake has a channel_uuid only used to display
# a stake belongs to an asset thrue a uuid and a type





# is attached to an shop item
class Stake < ActiveRecord::Base
  belongs_to :account
  #belongs_to :asset, polymorphic: true
  
  default_scope -> { order('created_at ASC') }

  has_paper_trail
  include ErrorNotification
  
  validates :email, :split, presence: true
  validates_formatting_of :email, :using => :email, :allow_nil => false
  validates_with StakeValidator
  
  after_create :set_relations
  before_destroy :remove_streams
  
  has_many :stripe_transfers, class_name: Shop::StripeTransfer
  has_many :gateway_payments

  after_commit :flush_cache
  
  def asset
    case self.asset_type
      
    when 'Recording'
      return Recording.find_by(uuid: self.asset_id)
    end
  end
  

  def update_income gateway_payment
    income = 0
    fees   = 0
    #psql exesizee
    self.gateway_payments.each do |gateway_payment|
      income += gateway_payment.amount
      fees   += gateway_payment.fee.round
      ap income
      ap fees
    end
    
    self.update(
      generated_income: income,
      generated_fee: fees
    )
    ap self
  end
  
  def fees
    generated_fee
  end
  
  def income
    generated_income - generated_fee
  end
  
  def units_sold
   self.gateway_payments.count
  end
  
  def title
    self.asset ? self.asset.title : 'na'
  end
  
  def unit_price
    @unit_price ||= calculate_unit_price
  end
  
  def stakeholders
    Stake.where(asset_type: self.class.name, asset_id: self.id)
  end
  

 
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  

  
  def title
    begin
      return self.asset.title
    rescue => e
      errored('Stake#description', e )
    end
    '500 na'
  end
  
  def description
    case self.ip_type
    when 'RecordingIpi'
      return  'Master royalty'
    when 'Ipi'
      return 'Mechanical royalty'
    when 'PublishingAgreement'
      return 'Publishing'
    when 'DistributionAgreement'
      return 'Distribution'
    end
  end
  
  def charge_succeeded params
  
    begin
      transfer_to_stakeholders_account params
      transfer_to_shared_streams params
    
      # cache income and fees
      #self.update(
      #  generated_income: generated_income + gateway_payment.amount,
      #  generated_fee:    generated_fee    + gateway_payment.fee.round
      #)
    rescue => e
      post_error "Stake#charge_succeeded: #{e.inspect}"
    end
  end
  
  private 

  # create a stripe transfer 
  def transfer_to_stakeholders_account params
    
    begin
      order_item             = Shop::OrderItem.cached_find( params[:order_item_id] )
      # sending transfers with same sender and recipient will fail
      unless order_item.seller_account_id == order_item.buyer_account_id
        
        case self.ip_type
        when "PublishingAgreement", "Ipi"
          params[:amount]           = self.flat_rate_in_cent
          params[:application_fee]  = 0
        else
          params[:amount]           = (self.flat_rate_in_cent - params[:payment_fee]).round.to_i
          application_fee           = (params[:amount].to_f * 0.02 ).round.to_i 
          application_fee           = 1 if( application_fee < 1 )
          params[:application_fee]  = application_fee
        end
        send_micro_transaction params
      end
    
    rescue => e
      errored('Stake#transfer_to_stakeholders_account', e )
    end         
  end

  def transfer_to_shared_streams params
    begin
      self.stakeholders.each do |stakeholder|
        stakeholder.charge_succeeded params
      end
    rescue => e
      errored('Stake#transfer_to_shared_streams', e )
    end 
  end
  
  def send_micro_transaction  params
    ap 'send_micro_transaction'
    ap params
    
    begin
      # prevent the same transfer to run two times
      stripe_transfer = Shop::StripeTransfer
      .where(   
        shop_order_id:        params[:order_id],
        shop_order_item_id:   params[:order_item_id], 
        account_id:           self.account_id,
        user_id:              self.user_id,  
        stake_id:             self.id
      )
      .first_or_create( 
        shop_order_id:        params[:order_id],
        shop_order_item_id:   params[:order_item_id], 
        account_id:           self.account_id,
        user_id:              self.user_id,  
        stake_id:             self.id,  
        source_transaction:   params[:stripe_charge_id],
        destination:          self.account.user.stripe_id, 
        #split:                self.split,
        amount:               params[:amount],
        currency:             'usd',
        application_fee:      params[:application_fee]
      )
      #ap stripe_transfer
      stripe_transfer.pay
      #update_income gateway_payment if stripe_transfer.pay
    rescue => e
      errored('Stake#micro_transaction', e )
    end 
  end
  
  
  
  
  
  # optimize this . Cache in field
  def calculate_unit_price
    #ap 'calculate_unit_price'
    #ap self.asset_type
    #price = 0.0
    #case self.asset_type
    #when 'Shop::Product'
    #  price = asset.price.to_f * 0.0001 * self.split if self.asset  
    #when 'Stake'
    #  stake = Stake.cached_find(self.asset_id)
    #  price = stake.unit_price * stake.split * 0.0001
    #when 'Recording'
    #  if recording = Recording.find_by(uuid: self.asset_id)
    #    if product = recording.product
    #      price    = product.price * self.split * 0.0001
    #    end
    #  end
    #  #price = asset
    #end
    #price
    123
  end
  
  def set_relations
    #if new_record?
    #  self.original_source = self.income_source
    #  save
    #end
    attach_to_user
  end
  


  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end 
  
  def remove_streams
    self.stripe_transfers.destroy_all
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
    else
      self.unassigned   = false
    end 
    self.save!
  end
  
  
  
end
