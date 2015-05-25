class ClientInvitation < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :client

  after_commit :flush_cache
  
  #after_create :send_one_with_avatar
  
  enum sendgrid_status: [ :pending, :processed, :dropped, :delivered, :opened, :clicked, :bounced, :unsubscribed ]
  
  
  def send_one_with_avatar
    ClientInvitationMailer.delay.send_one_with_avatar( self.id )
  end
  
  

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

  private 


  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end

  
end
