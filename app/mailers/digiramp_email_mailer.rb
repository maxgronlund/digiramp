class DigirampEmailMailer < ActionMailer::Base
  default from: "info@digiramp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.digiramp_email.news_email.subject
  #
  def news_email digiramp_email_id
    
    @digiramp_email = DigirampEmail.find(digiramp_email_id)
    
    receipients = []
    @digiramp_email.recipients.split(',').each_with_index do |receipient, index|
      receipients[index]  = receipient.gsub(' ', '')
    end
    
    #headers['X-SMTPAPI'] = '{ "to": ' +  receipients.to_s + '}'
    ap '{"to": '+ receipients.to_s + '}'
    
    ap '{"to": ["max@pixelsonrails.com", "test01@pixelsonrails.com"]}'

     
    
    
    
    
    
    headers['X-SMTPAPI'] = '{ "to": '+ receipients.to_s + '}'
    #headers['X-SMTPAPI'] = '{
    #                          "to": [
    #                                  "max@digiramp.com",
    #                                  "test03@pixelsonrails.com",
    #                                  "test04@pixelsonrails.com",
    #                                  "test05@pixelsonrails.com",
    #                                  "test06@pixelsonrails.com"
    #                                ]
    #                        }'
 
    
    
    mail to: "info@digiramp.com"
  end
end
