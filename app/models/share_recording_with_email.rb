class ShareRecordingWithEmail < ActiveRecord::Base
  belongs_to :user
  belongs_to :recording
  
  #after_create :send_emails
  after_commit :flush_cache
  
  def send_emails
    
    ap self
    
    self.recipients.split(',').each do |email|
      if EmailValidator.validate( email )
        ShareRecordingWithEmailMailer.delay.send_email( self.id, email )                         
      end
    end
    
    sender = User.cached_find(self.user_id)
    
    channel = 'digiramp_radio_' + sender.email
    Pusher.trigger(channel, 'digiramp_event', {"title" => 'RECORDING SHARED', 
                                          "message" => "An email is send", 
                                          "time"    => '15000', 
                                          "sticky"  => 'false', 
                                          "image"   => 'notice'
                                          })
    
    
  end
  
  

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end

private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
