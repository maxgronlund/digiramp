# The Ipi representent an Interested Pary Information
# Its also responsible for 

class Ipi < ActiveRecord::Base
  
  has_one :address
  accepts_nested_attributes_for :address
  include AddressMix
  
  #has_paper_trail

  
  belongs_to :pro_affiliation
  
  #belongs_to :import_ipi
  has_many :common_work_ipis
  belongs_to :user
  validates_with IpiValidator 
  #validates_presence_of :email
  validates_formatting_of :email, :using => :email, :allow_nil => false
  #validates_numericality_of :share, less_than_or_equal_to: 100
  after_create :attach_to_user
  #after_update :attach_user_credits
  #before_destroy :remove_user_credits
  
  #has_many :ipi_publishers
  #has_many :publishers,   :through => :ipi_publishers 
  
  
  after_commit :flush_cache
  
  def create_stake amount_in_cent, shop_product, recording
    Notifyer.print( 'Ipi#create_stake' , shop_product: shop_product ) if Rails.env.development?
    begin
      stake = Stake.create(  
        account_id:          self.user.account.id,
        user_id:             self.user_id,
        asset_id:            recording.uuid,
        asset_type:          recording.class.name,
        ip_uuid:             self.uuid,
        ip_type:             self.class.name,
        split:               amount_in_cent /  shop_product.price,
        flat_rate_in_cent:   amount_in_cent,
        currency:            'usd',
        email:               self.user.email,
        unassigned:          false,
        shop_product_id:     shop_product.id,
        description:         "Creators Split for #{user.get_full_name}",
        shop_product_id:     shop_product.id
      )
    rescue => e
      ErrorNotification.post_object 'Ipi#create_stake', e
    end
    
  end
  
  def update_stake amount_in_cent, shop_product, recording
    Notifyer.print( 'Ipi#update_stake' , shop_product: shop_product ) if Rails.env.development?
    begin
      if stake = Stake.find_by(  
          account_id:          self.user.account.id,
          user_id:             self.user_id,
          asset_id:            recording.uuid,
          asset_type:          recording.class.name,
          ip_uuid:             self.uuid,
          ip_type:             self.class.name,
          #shop_product_id:     shop_product.id,
        )
        stake.update_columns(  
          split:               amount_in_cent /  shop_product.price,
          flat_rate_in_cent:   amount_in_cent,
          currency:            'usd',
          email:               self.user.email,
          shop_product_id:     shop_product.id,
          description:         "Creators Split for #{user.get_full_name}",
          shop_product_id:     shop_product.id
        )
      else
        stake = Stake.create(  
          account_id:          self.user.account.id,
          user_id:             self.user_id,
          asset_id:            recording.uuid,
          asset_type:          recording.class.name,
          ip_uuid:             self.uuid,
          ip_type:             self.class.name,
          email:               self.user.email,
          unassigned:          false,
          shop_product_id:     shop_product.id,
          split:               amount_in_cent /  shop_product.price,
          flat_rate_in_cent:   amount_in_cent,
          currency:            'usd',
          email:               self.user.email,
          shop_product_id:     shop_product.id,
          description:         "Creators Split for #{user.get_full_name}"
        )
      end
      
    rescue => e
      ErrorNotification.post_object 'Ipi#create_stake', e
    end
    
  end

  
  def is_published?
    return true if self.user && self.user.publishers
    false
  end

  def publishing_agreement
    
  end
  
  def get_full_name
    if user
      user.full_name
    else
      self.full_name || '! registration pending'
    end
  end
  
  #def work_title
  #  self.common_work ? self.common_work.title : 'Work missing!'
  #end
  
  def get_account_id
    if user
      return user.get_account_id
    end
  end
  
  def get_account
    if user
      return user.account
    end
  end

  
  def send_confirmation_request
    # move this to common_work_ipi
    attach_to_user
    send_confirmation_email
    send_confirmation_notification
  end

  def attach_to_user
    self.update(uuid: UUIDTools::UUID.timestamp_create().to_s) if self.uuid.nil?
    return if self.user
    if user      = User.get_by_email(self.email)
      self.update(user_id: user.id, full_name: user.full_name)
      #self.save!(validate: false)
    end
  end
  
  
  # Attach to the users default publisher.
  def attach_to_publishers user
    #self.publisher_id
    return nil unless self.user

    if user.personal_publishing_status == "I have an exclusive publisher" || 
       user.personal_publishing_status == "I own and control my own publishing"
       self.publisher_id  = user.personal_publisher_id
       self.save(validate: false)
       attach_to_publishing_agreement
    else
      ap 'something fancy here'
    end 
  end
  
  
  
  #def attach_to_publisher
  #  if self.user
  #    if user.personal_publishing_status == "I own and control my own publishing"
  #      
  #    end
  #  end
  #end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  # boble up validation request to parrents
  def update_validation
    set_ok
    
    #self.common_works.each do |common_work|
    #  common_work.update_validation
    #end

  end
  
  # check if the ipi is valid return true or false
  def do_validation 
    return true if self.ok
    set_ok
    self.ok
  end
  
  def error_message
    em = {}
    #if self.user
      
    #em[:publisher]   = message_hash('No publisher assigned')  unless self.user.get_publisher rescue nil#publishers.empty?
    #
    #if publishing_agreements.empty?
    #  em[:publishing_agreement]   = message_hash('No publishing agreement') 
    #else
    #  publishing_agreements = []
    #  publishing_agreements.each do |publishing_agreement|
    #    
    #    unless publishing_agreement.do_validation
    #      #em["publishing_agreement_#{publishing_agreement.id}"] = publishing_agreement.error_message
    #      publishing_agreements << publishing_agreement.error_message
    #    end
    #  end
    #  em[:publishing_agreements] = publishing_agreements unless publishing_agreements.empty?
    #end
    em = message_hash(em) unless em.empty?
    em
  end
  
  # build a message has for the error message
  def message_hash msg
    {
      message:      msg,
      type: self.class.name,
      id:   self.id
    }
  end


private

  def set_ok
 
    update_columns( ok: error_message.empty? ) 
    #end   

  end


  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  def send_confirmation_email
    IpiMailer.delay.common_work_ipi_confirmation_email self.id
  end
  
  def send_confirmation_notification
    # if self.user
    #ap 'send_confirmation_notification'
  end
  
  #def send_confirmation_email_to_non_member
  #  ap 'send_confirmation_email_to_non_member'
  #  IpiMailer.delay.common_work_ipi_confirmation_email_to_non_member self.id
  #end
  
end




