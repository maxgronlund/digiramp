class AddDistributionAgreementIdToLabelRecordings < ActiveRecord::Migration
  def change
    add_column :label_recordings, :distribution_agreement_id, :string
    add_column :labels, :default_distribution_agreement_id, :string
    
    Label.find_each do |label|
      DistributionAgreement.create(label_id: label.id,
                                   distributor_id: label.id,
                                   account_id: label.account_id)
    end
    
    LabelRecording.find_each do |label_recording|
      label = label_recording.label
      label_recording.update(distribution_agreement_id: label.distribution_agreements.first.id)
    end
    
    Label.find_each do |label|
      label.update(default_distribution_agreement_id: label.distribution_agreements.first.id)
    end
    
  end
  
  
end
