class FollowerMailer < ApplicationMailer
  
  def recording_uploaded recording_id
    
    @recording = Recording.cached_find(recording_id)
    return unless @recording.privaty == 'Anyone'
    
    @user      = @recording.user

    @recording_url = url_for( controller: 'recordings', action: 'show', user_id: @user.slug, id: @recording.id)
    @recording_url = ( URI.parse(root_url) + @recording_url ).to_s
    
    @user.followers.each do |follover|
      receipients_with_names  << {email: follover.email, name: follover.user_name}
      merge_vars              << { rcpt: follover.email,
                                   vars: [ {name: "TITLE",            content: @recording.title},
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
end


#users.each do |user|
#  if user && email = EmailSanitizer.saintize( user.email )
#    receipients_with_names  << {email: email, name: user.user_name}
#    merge_vars              << { rcpt: email,
#                                 vars: [ {name: "IMAGE_1",          content: image_1},
#                                         {name: "TITLE_1",          content: digiramp_email.title_1},
#                                         {name: "BODY_1",           content: digiramp_email.body_1},
#                                         {name: "TITLE_2",          content: digiramp_email.title_2},
#                                         {name: "BODY_2",           content: digiramp_email.body_2},
#                                         {name: "LINK_1",           content: digiramp_email.link_1 },
#                                         {name: "LINK_1_TITLE",     content: digiramp_email.link_1_title },
#                                         {name: "TITLE_3",          content: digiramp_email.title_3},
#                                         {name: "BODY_3",           content: digiramp_email.body_3},
#                                         
#                                         {name: "SHOW_TITLE_1",     content: !digiramp_email.title_1.blank?  },
#                                         {name: "SHOW_BODY_1",      content: !digiramp_email.body_1.blank?   },
#                                         {name: "SHOW_TITLE_2",     content: !digiramp_email.title_2.blank?  },
#                                         {name: "SHOW_BODY_2",      content: !digiramp_email.body_2.blank?   },
#                                         {name: "SHOW_LINK_1",      content: !digiramp_email.link_1.blank?  }, 
#                                         {name: "SHOW_TITLE_3",     content: !digiramp_email.title_3.blank?  },
#                                         {name: "SHOW_BODY_3",      content: !digiramp_email.body_3.blank?   },
#                                         {name: "UNSUBSCRIBE_LINK", content: unsibscribe_link}
#                                       ]
#                                }
#  end
#end
#
#unless receipients_with_names.empty?
#  send_with_mandrill( receipients_with_names, 
#                      "news-email", 
#                      'DigiRAMP news', 
#                      ["news", "digiramp"], 
#                      merge_vars,
#                      true, 
#                      true, 
#                      "00-digiramp-news"
#                    )
#end