require 'uri'

class DigirampEmailMailer < ActionMailer::Base
  default from: "info@digiramp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.digiramp_email.news_email.subject
  #
  def news_email digiramp_email_id
    
    @digiramp_email = DigirampEmail.find(digiramp_email_id)
    @email_group    = @digiramp_email.email_group
    
    receipients = []
    index = 0
    @email_group.users.each do |user|
      
      if email = EmailValidator.saintize( user.email )
        receipients[index] = email
        index += 1
      end
      
    end


     
    
    
    @image_1 = (URI.parse(root_url) + @digiramp_email.image_1_url(:banner_558x90)).to_s
    
    #@unsibscribe_link = url_for unsubscribe_index_path(uuid: @digiramp_email.email_group.uuid)
    link = url_for unsubscribes_path(uuid: @digiramp_email.email_group.uuid)
    
    @unsibscribe_link = (URI.parse(root_url) + link).to_s
    
    
    headers['X-SMTPAPI'] = '{ "to": '+ receipients.to_s + '}'
    
    
    
    
    mail to: "info@digiramp.com"
  end
end