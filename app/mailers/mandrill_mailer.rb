class MandrillMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mandrill_mailer.send_test.subject
  #
  
  def mandril_client
    @mandrill_client ||= Mandrill::API.new Rails.application.secrets.email_provider_password
  end
  
  
  
  
  def send_with_api
    
    template_name = "mandrill-test"
    template_content = []
    message = {
      to: [{email: "max@pixelsonrails.com", name: 'Loco captain'}],
      subject: "Testing mandrill: #{'some thing dynamic'}",
      merge_vars: [
        {rcpt: "max@pixelsonrails.com",
         vars: [
          {
            name: "MANDRILL_TEST", content: "chunky beacon"
          }
        ]
      }
      ]
    }
    
    mandril_client.messages.send_template template_name, template_content, message
  end
end
