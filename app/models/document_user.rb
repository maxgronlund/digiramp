class DocumentUser < ActiveRecord::Base
  
  default_scope -> { order('created_at ASC') }
  
  include NotificationModule
  has_paper_trail 
  belongs_to :document, primary_key: :uuid
  belongs_to :user
  belongs_to :account
  belongs_to :digital_signature
  
  
  validates :email, presence: true
  validates_formatting_of :email, :using => :email
  
  enum status: [ :pending, :accepted, :dismissed ]
  
  after_commit :flush_cache
  

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  
  
  def assign_to_user
    if self.email
      if user = User.get_by_email( self.email )
        self.update(user_id: user.id)
        notify_user( user )
      else
        invite_and_notify user
      end
    end
    
  end
  
  def full_name
    return user.get_full_name if user
    'not assigned'
  end

  def update_validation
    ap 'document_user # update_validation'
    set_ok
    document.update_validation
  end
  
  def do_validation 
    return true if self.ok
    set_ok
    self.ok
  end
  
  def error_message
    em = {}
    
    if self.should_sign && self.digital_signature_id.nil?
      em[:signed] = 'Not signed'
    end
    
    unless self.user
      em[:user] = 'Not attached to user'
    end
    
    unless self.email
      em[:email] = 'Identification email missing'
    end
    
  end

  private 
  
  def set_ok
    em = error_message 
    ap em
    update_columns( ok: em.blank? )
    if self.user
      self.ok ? remove_notification_message(self.user_id) :
      update_notification_message(self.user_id).update_columns(
        error_massage: em
      )
    end
  end
  
  
  
  def notify_user user
    ap 'notify user'
  end
  
  def invite_and_notify user
     ap 'invita and notify user'
  end

  def flush_cache
    update_validation unless self.destroyed?
    Rails.cache.delete([self.class.name, id])
  end
  
  
  
  
end
