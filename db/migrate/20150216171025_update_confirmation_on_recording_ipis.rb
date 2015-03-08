class UpdateConfirmationOnRecordingIpis < ActiveRecord::Migration
  def change
    RecordingIpi.find_each do |recording_ipi|
      recording_ipi.confirmation = 'missing'
      recording_ipi.save!
    end
  end
end
