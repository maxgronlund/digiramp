class PlaylistEmailMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.playlist_email_mailer.send.subject
  #
  def send_email(playlist_email_id)
    
    playlist_email          = PlaylistEmail.cached_find(playlist_email_id)
    playlist                = playlist_email.playlist
    body                    = playlist_email.body
    @recordings              = playlist.recordings
    user                    = User.cached_find(playlist_email.user_id)
    
    playlist_recordings     = render_to_string('playlist_emails/index', layout: false)
    
    #digiramp_email         = DigirampEmail.find(digiramp_email_id)
    #
    #receipients_with_names = []
    #merge_vars             = []
    #image_1                = (URI.parse(root_url) + digiramp_email.image_1_url(:banner_558x90)).to_s
    #link                   = url_for unsubscribes_path(uuid: digiramp_email.email_group.uuid)
    #unsibscribe_link       = (URI.parse(root_url) + link).to_s
    receipients_with_names  = []
    merge_vars              = []
    
    playlist_email.email_list.split(',').each do |email|
      if user && email = EmailSanitizer.saintize( email )
        receipients_with_names  << {email: email, name: user.user_name}
        merge_vars              << { rcpt: email,
                                     vars: [ {name: "USER_NAME",                  content: user.user_name},
                                             {name: "TITLE",                      content: playlist_email.title},
                                             {name: "BODY",                       content: playlist_email.body},
                                             {name: "PLAYLIST_RECORDINGS",        content: playlist_recordings}
                                           ]
                                    }
      end
    end

    unless receipients_with_names.empty?
      send_with_mandrill( receipients_with_names, 
                          "playlist-player", 
                          'DigiRAMP playlist', 
                          ["playlist", "player"], 
                          merge_vars,
                          true, 
                          true, 
                          user.mandrill_account_id
                        )
    end
    
    
    
    
    
    
    
    
    
    
    #playlist_email.email_list.split(',').each do |email|
    #  mail to: email.strip, subject: @playlist_email.title
    #end
  end
end
