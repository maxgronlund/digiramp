class PlaylistEmailMailer < ActionMailer::Base
  default from: "noreply@digiramp.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.playlist_email_mailer.send.subject
  #
  def send_email(playlist_email_id)
    
    @playlist_email = PlaylistEmail.cached_find(playlist_email_id)
    @playlist       = @playlist_email.playlist
    @body           = @playlist_email.body
    @recordings     = @playlist.recordings
    @user_id        = @playlist_email.user_id
    
    @playlist_email.email_list.split(',').each do |email|
      mail to: email.strip, subject: @playlist_email.title
    end
  end
end
