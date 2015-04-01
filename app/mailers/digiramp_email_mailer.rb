require 'uri'

class DigirampEmailMailer < ActionMailer::Base
  default from: "noreply@digiramp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.digiramp_email.news_email.subject
  #
  def news_email users, digiramp_email_id
    
    @digiramp_email   = DigirampEmail.find(digiramp_email_id)
    receipients = []
    index       = 0
    users.each do |user|
      if user && email = EmailSanitizer.saintize( user.email )
        receipients[index] = email
        index += 1
      end
    end
    unless receipients.empty?
     
      @image_1            = (URI.parse(root_url) + @digiramp_email.image_1_url(:banner_558x90)).to_s
      link                = url_for unsubscribes_path(uuid: @digiramp_email.email_group.uuid)
      @unsibscribe_link   = (URI.parse(root_url) + link).to_s
      
      
      
      headder = '{ "to": '+ receipients.to_s + '}'
      #IssueEvent.create(title: 'DigirampEmailMailer#news_email', data: headder, subject_type: 'DigirampEmail', subject_id: digiramp_email_id)
      headers['X-SMTPAPI'] = headder
      mail to: "info@digiramp.com"
    end

  end
  
  def opportunity_created users, digiramp_email_id
    
    @digiramp_email   = DigirampEmail.cached_find(digiramp_email_id)
    @opportunity_url  = url_for( controller: '/public_opportunities', action: 'show', id: @digiramp_email.opportunity_id)


    receipients = []
    index = 0
    
    users.each do |user|
      if user && email = EmailSanitizer.saintize( user.email )
        receipients[index] = email
        index += 1
      end
    end
    unless receipients.empty?
      link = url_for unsubscribes_path(uuid: @digiramp_email.email_group.uuid)
      @unsibscribe_link = (URI.parse(root_url) + link).to_s
      
      headder = '{ "to": '+ receipients.to_s + '}'
      #IssueEvent.create(title: 'DigirampEmailMailer#opportunity_created', data: headder, subject_type: 'DigirampEmail', subject_id: digiramp_email_id)
      headers['X-SMTPAPI'] = headder
      
      mail to: "info@digiramp.com"
    end
  end
  
end
