# Preview all emails at http://localhost:3000/rails/mailers/recording_mailer
class RecordingMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/recording_mailer/send_attachement
  def send_attachement
    RecordingMailer.send_attachement
  end

end
