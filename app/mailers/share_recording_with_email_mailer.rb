class ShareRecordingWithEmailMailer < ActionMailer::Base
  
  def send_email id , email
     
    share_recording_with_email = ShareRecordingWithEmail.cached_find( id )
    @title     = share_recording_with_email.title
    @message   = share_recording_with_email.message
    
    puts '====================================================================='
    puts '====================================================================='
    ap share_recording_with_email
    mail to: email,  subject: share_recording_with_email.title
     
  end
 
end
