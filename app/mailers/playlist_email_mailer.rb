class PlaylistEmailMailer < ApplicationMailer

  def send_email(playlist_email_id)
    
    playlist_email          = PlaylistEmail.cached_find(playlist_email_id)
    playlist                = playlist_email.playlist
    body                    = playlist_email.body
    @recordings             = playlist.recordings
    user                    = User.cached_find(playlist_email.user_id)
    playlist_recordings     = render_to_string('playlist_emails/index', layout: false)
    
    playlist_url            = url_for( controller: '/playlists', action: 'show', user_id: user.slug, id:  playlist.id )
    user_url                = url_for( controller: '/users', action: 'show', id: user.slug)
    receipients_with_names  = []
    merge_vars              = []
    
    playlist_email.email_list.split(',').each do |email|
      if user && email = EmailSanitizer.saintize( email )
        receipients_with_names  << {email: email, name: user.user_name}
        merge_vars              << { rcpt: email,
                                     vars: [ {name: "USER_NAME",                  content: user.user_name},
                                             {name: "TITLE",                      content: playlist_email.title},
                                             {name: "BODY",                       content: playlist_email.body},
                                             {name: "PLAYLIST_RECORDINGS",        content: playlist_recordings},
                                             {name: "PLAYLIST_URL",               content: playlist_url},
                                             {name: "USER_URL",                   content: user_url}
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
                          user.mandrill_account_id,
                          "mailchimp"
                        )
    end
    

  end
end
