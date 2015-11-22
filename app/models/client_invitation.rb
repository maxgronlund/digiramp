class ClientInvitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :client
  belongs_to :client_group

  after_commit :flush_cache
  after_create :update_user
  
  
  #after_create :send_one_with_avatar
  validates_formatting_of :email, :using => :email
  
  #enum sendgrid_status: [ :pending, :processed, :dropped, :delivered, :opened, :clicked, :bounced, :unsubscribed ]
  enum state: [ :pending, :sent, :delivered, :hard_bounce, :soft_bounce, :bounced, :unsubscribed, :spam, :unsub, :reject ]
  
  def send_one_with_avatar
    ClientInvitationMailer.delay.send_one_with_avatar( self.id )
  end

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def update_user
    begin
      self.user.set_has_invited_friends
    rescue
    end
  end
  
  def update_parent
   
  end

  private 


  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  
end
