class ShareRecordingWithEmailMailer < ActionMailer::Base
  default from: "noreply@digiramp.com"
  
  def send_email id , email
     
    share_recording_with_email  = ShareRecordingWithEmail.find( id )

    @title                      = share_recording_with_email.title
    @message                    = share_recording_with_email.message
    @recording                  = share_recording_with_email.recording
    @cover_art                  = @recording.cover_art || @recording.get_cover_art
    @recording_link             = url_for( controller: 'recordings', action: 'show', user_id: @recording.user_id, id: @recording.id  )
    @fotter_link                = url_for( controller: 'contacts', action: 'new')

    mail to: email,  subject: share_recording_with_email.title
    

  end
 
end
