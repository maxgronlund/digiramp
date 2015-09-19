class AddDistributionAgreementIdToExistingLabelRecordings < ActiveRecord::Migration
  def change
    LabelRecording.find_each do |label_recording|
      label_recording.update(distribution_agreement_id: label_recording.label.distribution_agreementst .first.id)
    end
  end
end
