class FollowerMailer < ApplicationMailer
  
  def recording_uploaded recording_id
    
    @recording = Recording.cached_find(recording_id)
    return unless @recording.privacy == 'Anyone'
    
    @user      = @recording.user
    @user_avatar  = ( URI.parse(root_url) + @user.image_url(:avatar_92x92) ).to_s
    @user_url     = url_for( controller: 'users', action: 'show', id: @user.slug)
    @user_url     = ( URI.parse(root_url) + @user_url ).to_s

    @recording_url = url_for( controller: 'recordings', action: 'show', user_id: @user.slug, id: @recording.id)
    @recording_url = ( URI.parse(root_url) + @recording_url ).to_s
    
    @title = "#{@user.user_name} uploaded a new recording"
    
    receipients_with_names = []
    merge_vars             = []
    
    @user.followers.each do |follover|
      receipients_with_names  << {email: follover.email, name: follover.user_name}
      merge_vars              << { rcpt: follover.email,
                                   vars: [
                                           {name: "USER_NAME",          content: @user.user_name},
                                           {name: "USER_URL",           content: @user_url},
                                           {name: "TITLE",              content: @title},
                                           {name: "RECORDING_URL",      content: @recording_url},
                                           {name: "COMMENT",            content: @recording.comment},
                                           {name: "AVATAR_URL",         content: @user_avatar},
                                           {name: "PROFESION",          content: @user.profession},
                                           {name: "SHORT_DESCRIPTION",  content: @user.short_description},
                                           {name: "WRITER",             content: @user.writer},
                                           {name: "AUTHOR",             content: @user.author},
                                           {name: "PRODUCER",           content: @user.producer},
                                           {name: "COMPOSER",           content: @user.composer},
                                           {name: "REMIXER",            content: @user.remixer},
                                           {name: "MUSICIAN",           content: @user.musician},
                                           {name: "DJ",                 content: @user.dj},
                                           {name: "ARTIST",             content: @user.artist}
                                         ]
                                     }
    end
    unless receipients_with_names.empty?
      send_with_mandrill( receipients_with_names, 
                          "followed-user-uploaded-a-recording", 
                          'DigiRAMP update', 
                          ["notifications", "follower", "recording"], 
                          merge_vars,
                          true, 
                          true, 
                          @user.mandrill_account_id
                        )
    end

  end
end


# FollowerMailer.recording_uploaded( Recording.last)

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