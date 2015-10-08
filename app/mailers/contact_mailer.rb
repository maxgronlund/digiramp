class ContactMailer < ApplicationMailer

  def contace_received contact_id
    SlackService.contact_request_received() #if Rails.env.production?
    contact          = Contact.cached_find(contact_id)
    rcpt_email       = 'contact@digiramp.com'

    begin
      template_name = "contact-request-received"
      template_content = []
      message = {
        to: [{email: rcpt_email , name: 'Contact request' }],
        from: {email: "noreply@digiramp.com"},
        subject: contact.title,
        tags: ["contact-request"],
        track_clicks: true,
        track_opens: true,
        subaccount: "09-digiramp-contact-request", #User.first.mandrill_account_id,
        recipient_metadata: [{rcpt: rcpt_email, values: {contact_id: contact_id}}],
        merge_vars: [
          {
           rcpt: rcpt_email,
           vars: [
                   {name: "TITLE",       content: contact.title},
                   {name: "BODY",        content: contact.body},
                   {name: "SEND_FROM",    content: contact.email}
                ]
          }
        ]
      }
      mandril_client.messages.send_template template_name, template_content, message
    rescue Mandrill::Error => e
      ErrorNotification.post_object 'ContactMailer#contace_received', e
    end

  end

end
