require 'uri'

class MessageMailer < ActionMailer::Base

  def mandril_client
    @mandrill_client ||= Mandrill::API.new Rails.application.secrets.email_provider_password
  end

  def send_message message_id
    # extract data
    if message          = Message.cached_find(message_id)
      if receiver       = message.receiver
        if rcpt_email   = receiver.email
          sender        = message.sender
          message_url   = url_for( controller: 'messages', action: 'show', user_id: receiver.id, id: message_id)
          avatar_url    = ( URI.parse(root_url) + sender.image_url(:avatar_92x92) ).to_s
          sender_url    = url_for( controller: 'users', action: 'show', id: sender.slug)
          sender_url    = ( URI.parse(root_url) + sender_url ).to_s
        end
      end
    end

    # perform 
    if sender 
      begin
        template_name = "personal-message"
        template_content = []
        message = {
          to: [{email: rcpt_email , name: receiver.user_name }],
          from: {email: "no-reply@dirigamp.com"},
          subject: message.title,
          tags: ["personal-message"],
          track_clicks: true,
          track_opens: true,
          subaccount: sender.mandrill_account_id,
          recipient_metadata: [{rcpt: rcpt_email, values: {message_id: message.id}}],
          #subaccount: sender.id.to_s,
          merge_vars: [
            {
             rcpt: rcpt_email,
             vars: [
                     {name: "TITLE",       content: message.title},
                     {name: "BODY",        content: message.body},
                     {name: "SENDER_NAME", content: sender.user_name},
                     {name: "MESAGE_URL",  content: message_url},
                     {name: "AVATAR_URL",  content: avatar_url},
                     {name: "SENDER_URL",  content: sender_url},
                     {name: "MESAGE_ID",   content: message.id.to_s}
                     ]
            }
          ]
        }
        mandril_client.messages.send_template template_name, template_content, message
      rescue Mandrill::Error => e
        Opbeat.capture_message("#{e.class} - #{e.message}")
      end
    # handle error  
    else
      Opbeat.capture_message("MessageMailer:message_id #{message_id}")
    end
  end
end
