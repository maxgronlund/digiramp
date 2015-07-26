class RecordingIpiMailer < ApplicationMailer

  

  def recording_ipi_confirmation_email recording_ipi_id
    return unless recording_ipi  = RecordingIpi.cached_find(recording_ipi_id)
    link             = url_for( controller: 'confirmation/recording_ipi_confirmations', action: 'show', id: recording_ipi.uuid )
    email            = recording_ipi.email
    recording        = recording_ipi.recording
    recording_title  = recording.title
    account          = recording.account
    user             = account.user            
    title            = recording_ipi.title
    body             = recording_ipi.message

    # perform 
    if user 
      begin
        template_name = "recording-ipi-confirmation"
        template_content = []
        message = {
          to: [{email: email , name: recording_ipi.name }],
          from: {email: "noreply@digiramp.com"},
          subject: title,
          tags: ["recording", "ipi", "confirmation"],
          track_clicks: true,
          track_opens: true,
          subaccount: user.mandrill_account_id,
          recipient_metadata: [{rcpt: email, values: {recording_ipi_id: recording_ipi.id}}],
          merge_vars: [
            {
             rcpt: email,
             vars: [
                     {name: "TITLE",       content: title},
                     {name: "BODY",        content: body},
                     {name: "LINK",        content: link}
                     ]
            }
          ]
        }
        mandril_client.messages.send_template template_name, template_content, message
      rescue Mandrill::Error => e
        ErrorNotification.post "RecordingIpiMailer #{e.class} - #{e.message}"
      end
    # handle error  
    else
      ErrorNotification.post "RecordingIpiMailer: user not found"
    end
    
  end

end


