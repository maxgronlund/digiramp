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
  
  
  
  belongs_to :common_work
  belongs_to :pro_affiliation
  
  belongs_to :import_ipi
  belongs_to :user
  validates_with IpiValidator 
  validates_presence_of :email
  validates_formatting_of :email, :using => :email, :allow_nil => true
  #validates_numericality_of :share, less_than_or_equal_to: 100
  after_create :attach_to_user
  #after_update :attach_user_credits
  #before_destroy :remove_user_credits
  
  
  
  after_commit :flush_cache
  

  ROLES = [ "Writer", "Composer", "Administrator", "Producer", "Original Publisher",  "Artist", "Distributor", "Remixer", "Other", "Publisher"]
  
  def publishing_agreement document_uuid
    if publishing_agreement = PublishingAgreement.find_by(document_id: document_uuid)
      if ipi_publishing_agreement = IpiPublishingAgreement.where( publishing_agreement_id: publishing_agreement.id, ipi_id: self.id).first
        return true 
      end
    end
    return false
  end
  
  def configure_payment( royalty, price, recording_uuid, common_work_id )
    begin
      amount_in_cent =  share * 0.01 * royalty
      amount_in_pct  =  amount_in_cent /  price
      amount_in_pct  *= 100.0
      

      #ap '===================== IPs share ==============================='
      #ap 'Ipi#configure_payment'
      #ap "amount_in_pct: #{amount_in_pct}"
      #
      #ap '  GET IPS PUBLISHERS HERE'
      #
      #ap '  STASH STAKES HERE'
      #ap "uuid: #{self.uuid}"

      
      if stake = Stake.find_by( account_id:         self.user.account.id,
                                asset_id:           recording_uuid,
                                asset_type:         'Recording',
                                ip_uuid:            self.uuid,
                                ip_type:            self.class.name
                               )
        stake.update(
               split:               amount_in_pct,
               flat_rate_in_cent:   0,
               currency:            'usd',
               email:               self.user.email,
               unassigned:          false,
               
               )
      else
        stake = Stake.create(  account_id:          self.user.account.id,
                               asset_id:            recording_uuid,
                               asset_type:          'Recording',
                               ip_uuid:             self.uuid,
                               ip_type:             self.class.name,
                               split:               amount_in_pct,
                               flat_rate_in_cent:   0,
                               currency:            'usd',
                               email:               self.user.email,
                               unassigned:          false
                            )
      end
      
      
      
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
  
  def work_title
    self.common_work ? self.common_work.title : 'Work missing!'
  end
  
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
  
  #def update_relations
  #  add_uuid
  #  attach_to_user
  #  #attach_user_credits
  #end
  #
  #def attach_user_credits
    
    #if self.user
    #  user_credit = UserCredit
    #  .where(ipiable_type: self.class.name, ipiable_id: self.id, user_id: self.user_id)
    #  .first_or_create(title: self.common_work.title, ipiable_type: self.class.name, ipiable_id: self.id, user_id: self.user_id)
    #
    #  user_credit.confirmation               = self.confirmation
    #  user_credit.show_credit_on_recordings  = self.show_credit_on_recordings
    #  user_credit.save!
    #end
  #end
  
  
  #def remove_user_credits
  #  begin
  #    #UserCredit.wher(ipiable_type: self.common_work.class.name, ipiable_id: self.common_work_id, user_id: self.user_id)
  #  rescue
  #  end
  #end
  

  
  
  
  def send_confirmation_request
    attach_to_user
    send_confirmation_email
    send_confirmation_notification
    
  end

  def roles_as_string
    roles = ''
    roles += 'Writer. '           if self.lyric
    roles += 'Composer. '         if self.music
    roles += 'Arrengement. '      if self.arrangement
    roles += 'Melody. '           if self.melody
    roles                        
  end

  def attach_to_user
    self.update(uuid: UUIDTools::UUID.timestamp_create().to_s) if self.uuid.nil?
    return if self.user
    if user      = User.get_by_email(self.email)
      self.update(user_id: user.id, full_name: user.full_name)
      #self.save!(validate: false)
    end
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end


private



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




