class ShareRecordingWithEmail < ActiveRecord::Base
  belongs_to :user
  belongs_to :recording
  
  after_create :send_emails
  after_commit :flush_cache
  
  def send_emails

    send_emails = 0
    
    # !!! make a limitation here to avoid spammers
    self.recipients.split(',').each do |email|
      email.strip!
      if EmailSanitizer.validate( email )
        ShareRecordingWithEmailMailer.delay_for(1.second).send_email( self.id, email )  
        send_emails += 1                       
      end
    end

    if send_emails == 0
      message = 'No emails sent'
    elsif send_emails == 1
      message = 'One email sent'
    else
      message = send_emails.to_s
      message << 'emails sent'
    end
      
    channel = 'digiramp_radio_' + self.user.email
    Pusher.trigger(channel, 'digiramp_event', {"title" => 'RECORDING SHARED', 
                                          "message" => message, 
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
