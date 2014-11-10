class ShareRecordingWithEmail < ActiveRecord::Base
  belongs_to :user
  belongs_to :recording
  
  after_create :send_emails
  
  def send_emails
    
    #self.recipients.split(',').each do |email|
    #  if EmailValidator.validate( email )
    #    puts email
    #  end
    #end
    
    
  end
end
