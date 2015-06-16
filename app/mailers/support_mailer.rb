class SupportMailer < ApplicationMailer
  #default from: "info@digiramp.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.support_mailer.ticket_created.subject
  #
  def ticket_received user_id,  issue_id
    user      = User.cached_find user_id
    email     = user.email
    issue     = Issue.cached_find issue_id
    title     = issue.title
    body      = issue.body
    link      = url_for( controller: 'issues', action: 'show', user_id: user_id, id: issue_id)

    begin
      template_name = "support-ticket-received"
      template_content = []
      message = {
        to: [{email: email, name: user.user_name }],
        from: {email: "noreply@digiramp.com"},
        subject: title,
        tags: ["support", "ticket-received"],
        track_clicks: true,
        track_opens: true,
        subaccount: user.mandrill_account_id,
        recipient_metadata: [{rcpt: email, values: {issue_id: issue_id}}],
        merge_vars: [
          {
           rcpt: email,
           vars: [
                   {name: "TITLE",        content: title},
                   {name: "BODY",         content: body},
                   {name: "LINK",         content: link}
                  ]
          }
        ]
      }
      mandril_client.messages.send_template template_name, template_content, message
      Opbeat.capture_message("Support ticket: #{link}")
    rescue Mandrill::Error => e
      Opbeat.capture_message("#{e.class} - #{e.message}")
    end
   
  end
  
  def ticket_created
    @greeting = "Hi"

    #mail to: @user.email,  subject: title
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.support_mailer.comment_posted.subject
  #
  def comment_posted
    @greeting = "Hi"

    #mail to: @user.email,  subject: title
  end
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.support_mailer.issue_closed.subject
  #
  def issue_resolved user_id,  issue_id

    
    user      = User.cached_find user_id
    email     = user.email
    issue     = Issue.cached_find issue_id
    title     = issue.title
    body      = issue.body
    link      = url_for( controller: 'issues', action: 'show', user_id: user_id, id: issue_id)

    begin
      template_name = "support-ticket-resolved"
      template_content = []
      message = {
        to: [{email: email, name: user.user_name }],
        from: {email: "noreply@digiramp.com"},
        subject: title,
        tags: ["support", "ticket-received"],
        track_clicks: true,
        track_opens: true,
        subaccount: user.mandrill_account_id,
        recipient_metadata: [{rcpt: email, values: {issue_id: issue_id}}],
        merge_vars: [
          {
           rcpt: email,
           vars: [
                   {name: "TITLE",        content: title},
                   {name: "BODY",         content: body},
                   {name: "LINK",         content: link}
                  ]
          }
        ]
      }
      mandril_client.messages.send_template template_name, template_content, message
    rescue Mandrill::Error => e
      Opbeat.capture_message("#{e.class} - #{e.message}")
    end

    
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.support_mailer.issue_closed.subject
  #
  def issue_closed
    @greeting = "Hi"

    #mail to: @user.email,  subject: title
  end
  
  def contact contact_id
    
    @contact = Contact.cached_find(contact_id)
    #mail to: 'support@digiramp.com', subject: "Support ticket ##{@contact.id}"
  end
end

#SupportMailer.contact