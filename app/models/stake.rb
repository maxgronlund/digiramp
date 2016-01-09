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
  
  default_scope -> { order('created_at DESC') }

  has_paper_trail
  include ErrorNotification
  
  validates :email, :split, presence: true
  validates_formatting_of :email, :using => :email, :allow_nil => false
  validates_with StakeValidator
  
  after_create :set_relations
  before_destroy :remove_streams
  
  has_many :stripe_transfers, class_name: Shop::StripeTransfer
  has_many :incomes
  belongs_to :user

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
    when "Stake"
      return Stake.cached_find(self.asset_id)
    end
  end
  
  def type_of_asset
    case self.asset_type
    when 'Recording'
      return 'Recording'
    when 'Shop::Product'
      return 'Product'
    when 'RecordingIpi'
      return 'Production fee'
    when "DistributionAgreement"
      return 'Distribution fee'
    when "PublishingAgreement"
      return 'Royalty'
    when "Stake"
      return "Revenue split"
    end
    
  end

  
  def title
    self.asset ? self.asset.title : 'na'
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
      errored('Stake#title', e )
    end
    'na'
  end
  

  def fees 
    total =  self.stripe_transfers.where(state: 'finished').sum :application_fee
    total += self.stripe_transfers.where(state: 'finished').sum :payment_fee
    - total
    #total =  Income.where( stake_id: self.id ).sum :application_fee
    #total += Income.where( stake_id: self.id ).sum :payment_fee
    #- total
  end
  
  def income
    #Income.where( stake_id: self.id ).sum :amount
    self.stripe_transfers.where(state: 'finished').sum( :amount )
  end

  
  def units
    self.stripe_transfers.where(state: 'finished').count
  end
  
  
  # when a charge went true from stripe
  def charge_succeeded params

    Notifyer.print( 'Stake#charge_succeeded' , params: params ) if Rails.env.development?
    

    begin
      amount_after_fees     = (self.flat_rate_in_cent * params[:fees_in_percentage]).to_i
      params[:amount]       = amount_after_fees - substreams_amount( self, params )
      
      transfer_to_stakeholders_account params
      transfer_to_streams params
      
    rescue => e
      post_error "Stake#charge_succeeded: #{e.inspect}"
    end
  end
  
  
  
  def update_user
    attach_to_user
  end
  
  def unassigned
    return self.user ? false : true
  end
  
  private 
  
  # calculate how much is redistributed to child streams
  def substreams_amount parent_stake, params
    total_substreams_amount = 0
    parent_stake.stakeholders.each do |child_stake|
      # notice split is not used
      total_substreams_amount  += (child_stake.flat_rate_in_cent * params[:fees_in_percentage]).to_i
    end
    total_substreams_amount
  end
  
  
  # send  full ammount - streams to sellers account 
  def transfer_to_stakeholders_account params
    Notifyer.print( 'Stake#transfer_to_stakeholders_account' , params: params ) if Rails.env.development?
   
    
    begin
      order_item                = Shop::OrderItem.cached_find( params[:order_item_id] )
      params[:application_fee]  = Admin.digiramp_fees( params[:amount] )

      
      # sending transfers with same sender and recipient will fail
      unless order_item.seller_account_id == order_item.buyer_account_id
        send_micro_transaction params
      else
        Notifyer.print( 'Stake#transfer_to_stakeholders_account' , "Not sending money to origin account" ) if Rails.env.development?
      end
      
      update_income  params

    rescue => e
      errored('Stake#transfer_to_stakeholders_account', e )
    end         
  end
  
  
  
  
  #  send amount to streams
  def transfer_to_streams params
    
    Notifyer.print( 'Stake#transfer_to_streams' , params: params ) if Rails.env.development?

    begin
      self.stakeholders.each do |stake|

        params[:amount]               = stake.flat_rate_in_cent   * params[:all_fees_in_percent]
        params[:application_fee]      = stake.flat_rate_in_cent   - params[:amount]
 
        stake.charge_succeeded params
      end
    rescue => e
      errored('Stake#transfer_to_streams', e )
    end 
  end
  
  

  def send_micro_transaction  params
   
    
    if params[:amount].round == 0
      Notifyer.print( 'Stake#send_micro_transaction' , "Amount is: 0" ) if Rails.env.development?
      return
    end
    
    Notifyer.print( 'Stake#send_micro_transaction' , params: params ) if Rails.env.development?
    begin
      # prevent the same transfer to run two times
      stripe_transfer = Shop::StripeTransfer
      .where(   
        shop_order_id:        params[:order_id],
        order_item_id:        params[:order_item_id], 
        account_id:           self.account_id,
        user_id:              self.user_id,  
        stake_id:             self.id
      )
      .first_or_create( 
        shop_order_id:        params[:order_id],
        order_item_id:        params[:order_item_id], 
        account_id:           self.account_id,
        user_id:              self.user_id,  
        stake_id:             self.id,  
        #source_transaction:   params[:source_transaction],
        source_transaction:   params[:stripe_charge_id],
        destination:          self.account.user.stripe_id, 
        #split:                self.split,
        amount:               params[:amount].to_i,
        currency:             'usd',#,
        application_fee:      params[:application_fee],
        description:          params[:description]
      )
      #ap stripe_transfer
      if self.unassigned
        errored('Stake#micro_transaction', "stake: #{self.id} is unassigned" )
        #StakeMailer.delay.notify_unknown_stakeholder( self.id )
      elsif stripe_transfer.state == "finished"
        errored('Stake#micro_transaction', "stripe_transfer: #{stripe_transfer.id} is payed" )
      else
        stripe_transfer.pay
      end

      #update_income gateway_payment if stripe_transfer.pay
    rescue => e
      errored('Stake#micro_transaction', e )
    end 
  end


  
  def set_relations
    self.channel_uuid = UUIDTools::UUID.timestamp_create().to_s
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

    if user = User.find_by_email(self.email)
      self.account_id   = user.account.id
      self.user_id      = user.id
    end 
    self.save!
  
  end
  
  
  
  def update_income params

    Notifyer.print( 'Stake#update_income' , params: params ) if Rails.env.development?
    begin
      Income.create(
        stake_id:             self.id,
        user_id:              self.user_id,
        account_id:           self.account_id,
        amount:               params[:amount].round,
        application_fee:      params[:application_fee],
        source_transaction:   params[:stripe_charge_id]
      )
    rescue => e
      errored('Stake#update_income', e )
    end
  end
  
  
  
end
