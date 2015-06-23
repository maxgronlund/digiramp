class TestMailer < ApplicationMailer



  def send_message 
    # extract data
    

     
    



    begin
      template_name = "personal-message"
      template_content = []
      message = {
        to: [{email: 'max@digiramp.com' , name: 'Maxx' }],
        from: {email: "noreply@digiramp.com"},
        subject: 'Hi Test mailer',
        tags: ["personal-message"],
        track_clicks: true,
        track_opens: true,
        subaccount: 'cus-1',
        merge_vars: [
          {
           rcpt: 'max@digiramp.com',
           vars: [
                   {name: "TITLE",       content: 'from whenever'},
                   {name: "BODY",        content: 'message.body'},
                   {name: "SENDER_NAME", content: 'Whenever'},
                   {name: "MESAGE_URL",  content: 'https://digiramp.com'},
                   {name: "AVATAR_URL",  content: 'https://digiramp.com/uploads/user/image/1/avatar_184x184_Max-Avarar4.jpg'},
                   {name: "SENDER_URL",  content: 'https://digiramp.com'},
                   {name: "MESAGE_ID",   content: '123'}
                   ]
          }
        ]
      }
      mandril_client.messages.send_template template_name, template_content, message
    rescue Mandrill::Error => e
      Opbeat.capture_message("outch")
    end

  end
end


#TestMailer.delay.send_message() 