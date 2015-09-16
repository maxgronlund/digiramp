class LabelRecording < ActiveRecord::Base
  belongs_to :label
  belongs_to :recording
  
  belongs_to :distribution_agreement
  
  def receive_payment payment
    begin
      self.distribution_agreement.receive_payment( payment, self.recording_id )
    rescue => e
      ErrorNotification.post_object 'LabelRecording#receive_payment', e
    end
    
  end
  

end
