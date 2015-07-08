class IpiMailer < ApplicationMailer


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.ipi.confirm_recording.subject
  #
  def confirm_recording recording_ipi_id
    
    #recording_ipi = RecordingIpi.find(recording_ipi_id)
    #@greeting = "Hi"
    #
    #mail to: recording_ipi.email, subject: 'please confirm'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.ipi.confirm_common_work.subject
  #
  def common_work_ipi_confirmation_email ipi_id
    return ipi          = Ipi.cached_find(ipi_id)
    return email        = ipi.email
    return link         = url_for( controller: 'confirmation/ipi_confirmations', action: 'show', id: ipi.uuid )
    return subject      = "You are mentioned as an IPI on DigiRAMP"
    return title        = "Confirm IPI"
    return body         = "You have been mentioned as an IP on DigiRAMP Please confirm"
    return common_work  = ipi.common_work
    return account      = common_work.account
    return user         = account.user
    

    begin
      template_name = "ipi-confirmation"
      template_content = []
      message = {
        to: [{email: email }],
        from: {email: "noreply@digiramp.com"},
        subject: subject,
        tags: ["ipi", "confirmation", "common-work"],
        track_clicks: true,
        track_opens: true,
        subaccount: user.mandrill_account_id,
        recipient_metadata: [{rcpt: email, values: {ipi_id: ipi_id}}],
        merge_vars: [
          {
           rcpt: email,
           vars: [
                   {name: "TITLE",       content: title},
                   {name: "BODY",        content: body },
                   {name: "LINK",        content: link }
                   ]
          }
        ]
      }
      mandril_client.messages.send_template template_name, template_content, message
    rescue Mandrill::Error => e
      Opbeat.capture_message("#{e.class} - #{e.message}")
    end

  end
  

  def common_work_ipi_confirmation_email_to_non_member ipi_id
    #@greeting = "Hi"
    #
    #@ipi  = Ipi.cached_find(ipi_id)
    #
    #mail to: @ipi.email
  end
  
end


# IpiMailer.delay.common_work_ipi_confirmation_email