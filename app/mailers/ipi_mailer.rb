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
  def common_work_ipi_confirmation_email ipi_id

    @ipi        = Ipi.cached_find(ipi_id)
    
    @accept_url = 'http://digiramp.com'

    mail to: @ipi.email, subject: @ipi.title
  end
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.ipi.confirm_common_work.subject
  #
  def common_work_ipi_confirmation_email_to_non_member ipi_id
    @greeting = "Hi"
    
    @ipi  = Ipi.cached_find(ipi_id)

    mail to: @ipi.email
  end
  
end


