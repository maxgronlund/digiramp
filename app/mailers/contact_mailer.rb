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
    

    begin
      template_name = "contact-request-received"
      template_content = []
      message = {
        to: [{email: email, name: 'Contact request received' }],
        from: {email: 'contact@digiramp.com'},
        subject: title,
        tags: ["contact", "contact-received"],
        track_clicks: true,
        track_opens: true,
        subaccount: '09-contact-request',
        recipient_metadata: [{rcpt: email, values: {contact_id: contact_id}}],
        merge_vars: [
          {
           rcpt: email,
           vars: [
                   {name: "TITLE",        content: title},
                   {name: "BODY",         content: body},
                   {name: "SEND_FROM",    content: email}
                  ]
          }
        ]
      }
      mandril_client.messages.send_template template_name, template_content, message
      #Opbeat.capture_message("Contact received: #{link}")
      SlackService.contact_request_received() #if Rails.env.production?
      ap '=========================================== send ================================'
    rescue Mandrill::Error => e
      Opbeat.capture_message("#{e.class} - #{e.message}")
    end
  end
  
  
  
 
end

#SupportMailer.contact