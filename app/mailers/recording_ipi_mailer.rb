class RecordingIpiMailer < ActionMailer::Base
  default from: "noreply@digiramp.com"


  def recording_ipi_confirmation_email recording_ipi_id
    @recording_ipi          = RecordingIpi.cached_find(recording_ipi_id)
    @accept_url             = url_for( controller: 'confirmation/recording_ipi_confirmations', action: 'show', id: @recording_ipi.uuid )
    mail to: @recording_ipi.email, subject: @recording_ipi.title
  end

  
end


