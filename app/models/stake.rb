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
  has_many :incomes

  after_commit :flush_cache
  
  def asset
    case self.asset_type
      
    when 'Recording'
      return Recording.find_by(uuid: self.asset_id)
    when 'Shop::Product'
      return Shop::Product.cached_find(self.asset_id)
    when 'RecordingIpi'
      return RecordingIpi.find_by(uuid: self.asset_id)
    when "DistributionAgreement"
      return DistributionAgreement.find_by(uuid: self.asset_id)
    when "PublishingAgreement"
      return PublishingAgreement.cached_find(self.asset_id)
    end
  end
  

  #def update_income
  #  income = 0
  #  fees   = 0
  #  #psql exesizee
  #  self.stripe_transfers.each do |stripe_transfer|
  #    income += stripe_transfer.amount
  #    fees   += stripe_transfer.payment_fee + stripe_transfer.application_fee
  #  end
  #  
  #  self.update(
  #    generated_income: income,
  #    generated_fee: fees
  #  )
  #  ap self
  #end
  
  
  
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
      return self.asset.title if self.asset
      'na'
    rescue => e
      errored('Stake#description', e )
    end
    '500 na'
  end
  
  def description
    if self.ip_type
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
    else
      case self.asset_type
      when 'Shop::Product'
        return 'Physical product'
      end
    end
    'na'
  end
  
  def fees 
    total = Income.where( stake_id: self.id ).sum :application_fee
    total += Income.where( stake_id: self.id ).sum :payment_fee
    - total
  end
  
  def income
    Income.where( stake_id: self.id ).sum :amount
  end
  
  def units
    self.incomes.count
  end
  
  
  def charge_succeeded params
    ap 'Stake#charge_succeeded'
    ap params
    begin
      transfer_to_stakeholders_account params
      transfer_to_streams params
    rescue => e
      post_error "Stake#charge_succeeded: #{e.inspect}"
    end
  end
  
  
  private 

  # create a stripe transfer 
  def transfer_to_stakeholders_account params
    ap 'Stake#transfer_to_stakeholders_account'
    ap params
    begin
      
      params[:amount]           = self.flat_rate_in_cent * params[:all_fees_in_percent]
      params[:application_fee]  = self.flat_rate_in_cent - params[:amount]
      
      order_item                = Shop::OrderItem.cached_find( params[:order_item_id] )
      
      # sending transfers with same sender and recipient will fail
      unless order_item.seller_account_id == order_item.buyer_account_id
        send_micro_transaction params
      end
      
      update_income   params

    rescue => e
      errored('Stake#transfer_to_stakeholders_account', e )
    end         
  end
  
  def update_income params
    ap 'Stake#update_income'
    ap params
    Income.create(
      stake_id:             self.id,
      user_id:              self.user_id,
      account_id:           self.account_id,
      amount:               params[:amount].round,
      application_fee:      params[:application_fee].round,
      source_transaction:   params[:stripe_charge_id]
    )
  end
  
  

  def transfer_to_streams params
    
    
    begin
      self.stakeholders.each do |stake|
        params[:amount]           = params[:amount]            * stake.split
        params[:application_fee]   = params[:application_fee]  * stake.split
        params[:source_transaction] = nil   
        stake.charge_succeeded params
      end
    rescue => e
      errored('Stake#transfer_to_streams', e )
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
        amount:               params[:amount].round,
        currency:             'usd',
        application_fee:      params[:application_fee].round
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
