class Ipi < ActiveRecord::Base
  
  has_many :activity_events, as: :activity_eventable
  
  belongs_to :common_work
  belongs_to :pro_affiliation
  
  belongs_to :import_ipi
  belongs_to :user
  #validates_with IpiEmailValidator 
  validates_presence_of :email
  validates_formatting_of :email, :using => :email, :allow_nil => true
  after_create :update_relations
  after_update :attach_user_credits
  before_destroy :remove_user_credits
  
  after_commit :flush_cache
  

  ROLES = [ "Writer", "Composer", "Administrator", "Producer", "Original Publisher",  "Artist", "Distributor", "Remixer", "Other", "Publisher"]
  
  
  def update_relations
    add_uuid
    attach_to_user
    attach_user_credits
  end
  
  def attach_user_credits
    ap self
    if self.user
      user_credit = UserCredit
      .where(ipiable_type: self.class.name, ipiable_id: self.id, user_id: self.user_id)
      .first_or_create(title: self.common_work.title, ipiable_type: self.class.name, ipiable_id: self.id, user_id: self.user_id)

      user_credit.confirmation = self.confirmation
      user_credit.show_credit_on_recordings = self.show_credit_on_recordings
      user_credit.save!
    end
  end
  
  
  def remove_user_credits
    begin
      UserCredit.wher(ipiable_type: self.common_work.class.name, ipiable_id: self.common_work_id, user_id: self.user_id)
    rescue
    end
  end
  
  
  def add_uuid
    if self.uuid.to_s == ''
      self.uuid = UUIDTools::UUID.timestamp_create().to_s
      self.save!(validate: false)
    end
  end
  
  def attach_to_user
    if attach_to = User.get_by_email(self.email)
      self.user_id    = attach_to.id
      self.save!(validate: false)
    end
  end
  
  def send_confirmation_request
    attach_to_user
    send_confirmation_email
    send_confirmation_notification
    
  end

  def roles_as_string
    roles = ''
    roles += 'Writer. '              if self.writer
    roles += 'Composer. '            if self.composer
    roles += 'Administrator. '       if self.administrator
    roles += 'Original Publisher. '  if self.original_publisher
    roles                        
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




