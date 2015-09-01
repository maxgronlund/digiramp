class AddStatusToRecordingIpis < ActiveRecord::Migration
  def change
    add_column :recording_ipis, :status, :integer, default: 0
    
    RecordingIpi.find_each do |recording_ipi|
      recording_ipi.accepted! if recording_ipi.confirmed
    end
  end
end
