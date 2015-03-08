class IpiMailer < ActionMailer::Base
  default from: "noreply@digiramp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.ipi.confirm_recording.subject
  #
  def confirm_recording recording_ipi_id
    
    recording_ipi = RecordingIpi.find(recording_ipi_id)
    @greeting = "Hi"

    mail to: recording_ipi.email, subject: 'please confirm'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.ipi.confirm_common_work.subject
  #
  def confirm_common_work
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
