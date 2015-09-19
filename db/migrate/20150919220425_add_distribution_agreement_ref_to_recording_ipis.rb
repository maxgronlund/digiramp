class AddDistributionAgreementRefToRecordingIpis < ActiveRecord::Migration
  def change
    add_reference :recording_ipis, :distribution_agreement, index: true, foreign_key: true
    
    DistributionAgreement.find_each do |distribution_agreement|
      if recordings = distribution_agreement.recordings
        recordings.each do |recording|
          if recording_ipis = recording.recording_ipis
            recording_ipis.update_all(distribution_agreement_id: distribution_agreement.id)
          end
        end
      end
    end
  end
  
end
