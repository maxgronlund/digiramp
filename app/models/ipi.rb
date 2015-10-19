# The Ipi representent an Interested Pary Information
# Its also responsible for 

class Ipi < ActiveRecord::Base
  
  has_one :address
  accepts_nested_attributes_for :address
  include AddressMix
  
  #has_paper_trail
  enum status: [ :pending, :accepted, :dismissed, :in_progress ]
  
  has_many :activity_events, as: :activity_eventable
  
  #has_many :ipi_publishing_agreements
  has_many :ipi_publishing_agreements, dependent: :destroy
  has_many :publishing_agreements, :through => :ipi_publishing_agreements
  

  has_many :common_work_ipis
  has_many :common_works, :through => :common_work_ipis
  
  #belongs_to :common_work
  
  
  belongs_to :pro_affiliation
  
  belongs_to :import_ipi
  belongs_to :user
  validates_with IpiValidator 
  #validates_presence_of :email
  validates_formatting_of :email, :using => :email, :allow_nil => false
  #validates_numericality_of :share, less_than_or_equal_to: 100
  after_create :attach_to_user
  #after_update :attach_user_credits
  #before_destroy :remove_user_credits
  
  has_many :ipi_publishers
  has_many :publishers,   :through => :ipi_publishers 
  
  
  after_commit :flush_cache
  

  ROLES = [ "Writer", "Composer", "Administrator", "Producer", "Original Publisher",  "Artist", "Distributor", "Remixer", "Other", "Publisher"]
  
  
  
  

  

  # Configure the payment. whould be moved to CommonWorkIpi
  def configure_payment( royalty, price, recording_uuid )
    
    begin
      amount_in_cent =  royalty
      amount_in_pct  =  amount_in_cent /  price
      
      #ap "amount_in_cent: #{amount_in_cent}"
      #ap "royalty; #{royalty}"


      if stake = Stake.find_by( 
          account_id:         self.user.account.id,
          asset_id:           recording_uuid,
          asset_type:         'Recording',
          ip_uuid:            self.uuid,
          ip_type:            self.class.name
        )
        stake.update(
          split:               amount_in_pct,
          flat_rate_in_cent:   amount_in_cent,
          currency:            'usd',
          email:               self.user.email,
          unassigned:          false
        )
      else
        stake = Stake.create(  
          account_id:          self.user.account.id,
          user_id:             self.user_id,
          asset_id:            recording_uuid,
          asset_type:          'Recording',
          ip_uuid:             self.uuid,
          ip_type:             self.class.name,
          split:               amount_in_pct,
          flat_rate_in_cent:   amount_in_cent,
          currency:            'usd',
          email:               self.user.email,
          unassigned:          false
        )
      end
      ap stake
    rescue => e
      ErrorNotification.post_object 'Ipi#configure_payment', e
    end
  end
  
  def is_published?
    return true if self.user && self.user.publishers
    false
  end
  
  
  
  def users_publishing_agreements
    #return nil unless user
    return user.get_publishing_agreements
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

  #def roles_as_string
  #  roles = ''
  #  roles += 'Writer. '           if self.lyric
  #  roles += 'Composer. '         if self.music
  #  roles += 'Arrengement. '      if self.arrangement
  #  roles += 'Melody. '           if self.melody
  #  roles                        
  #end

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
    
    self.common_works.each do |common_work|
      common_work.update_validation
    end

  end
  
  # check if the ipi is valid return true or false
  def do_validation 
    return true if self.ok
    set_ok
    self.ok
  end
  
  def error_message
    em = {}
    em[:publisher]   = message_hash('No publisher assigned')   if publishers.empty?
    
    if publishing_agreements.empty?
      em[:publishing_agreement]   = message_hash('No publishing agreement') 
    else
      
      publishing_agreements.each do |publishing_agreement|
        
        unless publishing_agreement.do_validation
          em["publishing_agreement_#{publishing_agreement.id}"] = publishing_agreement.error_message
        
        end
      end
    end
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




