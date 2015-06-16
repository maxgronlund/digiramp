class ShareRecordingWithEmailMailer < ApplicationMailer

  
  def send_email id , email
     
    share_recording_with_email  = ShareRecordingWithEmail.find( id )
    user                        = share_recording_with_email.user
    title                       = share_recording_with_email.title
    message                     = share_recording_with_email.message
    recording                   = share_recording_with_email.recording
    #user                        = recording.user
    image_url                   = recording.cover_art || recording.get_cover_art
    link                        = url_for( controller: 'recordings', action: 'show', user_id: recording.user_id, id: recording.id  )
    #fotter_link                      = url_for( controller: 'contacts', action: 'new')

    


    begin
      template_name = "share-recording"
      template_content = []
      message = {
        to: [{email: email }],
        from: {email: "noreply@digiramp.com"},
        subject: title,
        tags: ["recording", "sharing"],
        track_clicks: true,
        track_opens: true,
        subaccount: user.mandrill_account_id,
        recipient_metadata: [{rcpt: email, values: {recordingid: recording.id}}],
        merge_vars: [
          {
           rcpt: email,
           vars: [
                   {name: "RECORDING_TITLE",    content: recording.title},
                   {name: "RECORDING_COMMENT",  content: recording.comment},
                   {name: "TITLE",              content: title},
                   {name: "MESSAGE",            content: message},
                   {name: "IMAGE_URL",          content: image_url},
                   {name: "LINK",               content: link}
                   ]
          }
        ]
      }
      mandril_client.messages.send_template template_name, template_content, message
    rescue Mandrill::Error => e
      Opbeat.capture_message("#{e.class} - #{e.message}")
    end

  end
 
end


# ShareRecordingWithEmailMailer