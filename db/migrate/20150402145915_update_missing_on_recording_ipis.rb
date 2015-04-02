class UpdateMissingOnRecordingIpis < ActiveRecord::Migration
  def change
    
    RecordingIpi.update_all(confirmation: 'Missing')
  end
end
