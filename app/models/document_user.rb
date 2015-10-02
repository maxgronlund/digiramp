class DocumentUser < ActiveRecord::Base
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

  private 
  
  def notify_user user
    ap 'notify user'
  end
  
  def invite_and_notify user
     ap 'invita and notify user'
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
  
  
end
