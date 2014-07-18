class RecordingMailer < ActionMailer::Base
  default from: "info@digiramp.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.recording_mailer.send_attachement.subject
  #
  def send_attachement
    @greeting = "Hi"
    ap @greeting
    mail to: "max@synthmax.dk"
  end
end
