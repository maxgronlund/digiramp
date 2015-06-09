# Preview all emails at http://localhost:3000/rails/mailers/playlist_email_mailer
class PlaylistEmailMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/playlist_email_mailer/send
  def send
    PlaylistEmailMailer.send
  end

end
