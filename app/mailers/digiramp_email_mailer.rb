require 'uri'

class DigirampEmailMailer < ApplicationMailer
  

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
                                             {name: "LINK_1",           content: digiramp_email.link_1 },
                                             {name: "LINK_1_TITLE",     content: digiramp_email.link_1_title },
                                             {name: "TITLE_3",          content: digiramp_email.title_3},
                                             {name: "BODY_3",           content: digiramp_email.body_3},
                                             
                                             {name: "SHOW_TITLE_1",     content: !digiramp_email.title_1.blank?  },
                                             {name: "SHOW_BODY_1",      content: !digiramp_email.body_1.blank?   },
                                             {name: "SHOW_TITLE_2",     content: !digiramp_email.title_2.blank?  },
                                             {name: "SHOW_BODY_2",      content: !digiramp_email.body_2.blank?   },
                                             {name: "SHOW_LINK_1",      content: !digiramp_email.link_1.blank?  }, 
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
                          merge_vars,
                          true, 
                          true, 
                          "00-digiramp-news"
                        )
    end
  end
  
  def opportunity_created users, digiramp_email_id
    
    if digiramp_email           = DigirampEmail.cached_find(digiramp_email_id)
      if opportunity            = Opportunity.cached_find(digiramp_email.opportunity_id)
        opportunity_link        = url_for( controller: '/public_opportunities', action: 'show', id: opportunity.id)
        receipients_with_names  = []
        merge_vars              = []
        link                    = url_for unsubscribes_path(uuid: digiramp_email.email_group.uuid)
        unsibscribe_link        = (URI.parse(root_url) + link).to_s
    
        
        users.each do |user|
          begin
            if email = EmailSanitizer.saintize( user.email )
              receipients_with_names  << { email: email, name: user.user_name}
              merge_vars              << { rcpt: email,
                                           vars: [ {name: "USER_NAME",              content:     user.user_name},
                                                   {name: "OPPORTUNITY_TITLE",      content:     opportunity.title},
                                                   {name: "OPPORTUNITY_BODY",       content:     opportunity.body},
                                                   {name: "OPPORTUNITY_LINK",       content:     opportunity_link},
                                                   {name: "UNSUBSCRIBE_LINK",       content:     unsibscribe_link}
                                                 ]
                              }
            end
          rescue => e
            Opbeat.capture_message( "DigirampEmailMailer#opportunity_created #{opportunity.id}" )
          end
        end
      end
    end
        
    unless receipients_with_names.empty?
      send_with_mandrill( receipients_with_names, 
                          "opportunity-email", 
                          'New opportunity on DigiRAMP', 
                          ["digiramp", "opportunity"], 
                          merge_vars,
                          true, 
                          true, 
                          "01-digiramp-opportunity-created"
                        )
    end
  end
end


