class ApplicationMailer < ActionMailer::Base
  
  def mandril_client
    @mandrill_client ||= Mandrill::API.new Rails.application.secrets.email_provider_password
  end
  
  def send_with_mandrill receipients_with_names, 
                         template_name, 
                         subject, 
                         tags, 
                         merge_vars, 
                         track_clicks, 
                         track_opens, 
                         subaccount,
                         merge_language
    begin
      template_name = template_name
      template_content = []
      message = { to: receipients_with_names ,
                  from_email: "noreply@digiramp.com",
                  from_name:  "NoReply@DigiRAMP.com",
                  subject: subject,
                  tags: tags,
                  track_clicks: track_clicks,
                  track_opens: track_opens,
                  subaccount: subaccount,
                  merge_language: merge_language,
                  merge_vars: merge_vars
                }
      mandril_client.messages.send_template template_name, template_content, message

    rescue Mandrill::Error => e
      message = "#{e.class} - #{e.message}"
      ErrorNotification.post message
    end
  end

  
  def error_msg msg
    Opbeat.capture_message( msg )
  end
  
end



