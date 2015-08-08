class IpiMailer < ApplicationMailer


  def common_work_ipi_confirmation_email ipi_id
    ipi          = Ipi.cached_find(ipi_id)
    email        = ipi.email
    link         = url_for( controller: 'confirmation/ipi_confirmations', action: 'show', id: ipi.uuid )
    
    common_work  = ipi.common_work
    account      = common_work.account
    user         = account.user
    subject      = "#{user.user_name} has mentioned you as an IP on DigiRAMP"
    title        = "Confirm IPI"
    body         = "You have been mentioned by #{user.user_name} as an IP on DigiRAMP Please confirm"
    

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
    rescue => e
      ErrorNotification.post "IpiMailer #{e.inspect}"
    end  
    
    begin
      mandril_client.messages.send_template template_name, template_content, message
    rescue Mandrill::Error => e
      ErrorNotification.post "IpiMailer#Mandrill - #{e.message}"
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