class ContactMailer < ApplicationMailer
  #default from: "info@digiramp.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.support_mailer.ticket_created.subject
  #
  def contace_received contact_id
    
    contact = Contact.cached_find( contact_id )

    email     = contact.email
    title     = contact.title
    body      = contact.body
    #link      = url_for( controller: 'contact', action: 'index', user_id: user_id, id: issue_id)
    
    begin
      template_name = "contact-request-received"
      template_content = []

      message = {
        to: [{email: 'contact@digiramp.com' , name: 'Contact request received' }],
        from: {email: "noreply@digiramp.com"},
        subject: "DigiRAMP Contact request",
        tags: ["contact", "support"],
        track_clicks: true,
        track_opens: true,
        subaccount: '09-contact-request',
        recipient_metadata: [{rcpt: 'contact@digiramp.com', values: {contact_id: 'fo'}}],
        merge_vars: [
          {
           rcpt: 'contact@digiramp.com',
           vars: 
           [ 
              {name: "TITLE",        content: title},
              {name: "BODY",         content: body},
              {name: "SEND_FROM",    content: email}
            ]
          }
        ]
      }
      ap mandril_client.messages.send_template template_name, template_content, message
    rescue Mandrill::Error => e
      ErrorNotification.post("#{e.class} - #{e.message}")
    end 
    
    

    ##begin
    #  template_name = "contact-request-received"
    #  template_content = []
    #  message = {
    #    to: [{email: 'contact@digiramp.com', name: 'Contact request received' }],
    #    from: {email: 'noreply@digiramp.com'},
    #    subject: title,
    #    tags: ["contact", "contact-received"],
    #    track_clicks: true,
    #    track_opens: true,
    #    #subaccount: '09-contact-request',
    #    recipient_metadata: [{rcpt: email, values: {contact_id: contact_id}}],
    #    merge_vars: [
    #      {
    #       rcpt: 'contact@digiramp.com',
    #       vars: [
    #               {name: "TITLE",        content: title},
    #               {name: "BODY",         content: body},
    #               {name: "SEND_FROM",    content: email}
    #              ]
    #      }
    #    ]
    #  }
    #  
    # 
    #  
    #  ap message
    #  ap mandril_client.messages.send_template( template_name, template_content, message )
    #  #Opbeat.capture_message("Contact received: #{link}")
    #  SlackService.contact_request_received() #if Rails.env.production?
    #  #rescue Mandrill::Error => e
    #  #Opbeat.capture_message("#{e.class} - #{e.message}")
      #end
  end
  
  
  
 
end

#SupportMailer.contact