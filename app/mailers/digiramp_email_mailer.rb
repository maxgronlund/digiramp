require 'uri'

class DigirampEmailMailer < ApplicationMailer
  default from: "noreply@digiramp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.digiramp_email.news_email.subject
  #
  def news_email users, digiramp_email_id
    
    digiramp_email         = DigirampEmail.find(digiramp_email_id)
    receipients_with_names = []
    merge_vars             = []
    
    image_1                = (URI.parse(root_url) + digiramp_email.image_1_url(:banner_558x90)).to_s
    link                   = url_for unsubscribes_path(uuid: digiramp_email.email_group.uuid)
    unsibscribe_link       = (URI.parse(root_url) + link).to_s

    users.each do |user|
      if user && email = EmailSanitizer.saintize( user.email )
        receipients_with_names  << {email: email, name: user.user_name}
        merge_vars              << { rcpt: email,
                                     vars: [ {name: "IMAGE_1",          content: image_1},
                                             {name: "TITLE_1",          content: digiramp_email.title_1},
                                             {name: "BODY_1",           content: digiramp_email.body_1},
                                             {name: "TITLE_2",          content: digiramp_email.title_2},
                                             {name: "BODY_2",           content: digiramp_email.body_2},
                                             {name: "LINK__1",          content: digiramp_email.body_3.blank?   },
                                             {name: "TITLE_3",          content: digiramp_email.title_3},
                                             {name: "BODY_3",           content: digiramp_email.body_3},
                                             
                                             {name: "SHOW_TITLE_1",     content: !digiramp_email.title_1.blank?  },
                                             {name: "SHOW_BODY_1",      content: !digiramp_email.body_1.blank?   },
                                             {name: "SHOW_TITLE_2",     content: !digiramp_email.title_2.blank?  },
                                             {name: "SHOW_BODY_2",      content: !digiramp_email.body_2.blank?   },
                                             {name: "SHOW_TITLE_3",     content: !digiramp_email.title_3.blank?  },
                                             {name: "SHOW_BODY_3",      content: !digiramp_email.body_3.blank?   },
                                             {name: "UNSUBSCRIBE_LINK", content: unsibscribe_link}
                                           ]
                        }
      end
    end

    unless receipients_with_names.empty?
      send_with_mandrill( receipients_with_names, 
                          "news-email", 
                          'DigiRAMP news', 
                          ["news", "digiramp"], 
                          merge_vars
                        )
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
