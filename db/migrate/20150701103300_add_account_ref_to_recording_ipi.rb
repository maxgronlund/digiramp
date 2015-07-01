class AddAccountRefToRecordingIpi < ActiveRecord::Migration
  def change
    add_reference :recording_ipis, :account, index: true, foreign_key: true
    
    RecordingIpi.find_each do |recording_ipi|
      recording_ipi.account_id = recording_ipi.recording.account_id
      recording_ipi.save!
    end
  end
end
