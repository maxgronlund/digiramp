class AddTitleToRecordingIpis < ActiveRecord::Migration
  def change
    add_column :recording_ipis, :title, :string   , default: ''
    add_column :recording_ipis, :message, :text , default: ''
    add_column :recording_ipis, :uuid, :string,   default: ''
    
    RecordingIpi.update_all(title: '', message: '')
    
    RecordingIpi.find_each do |recording_ipi|
      recording_ipi.uuid = UUIDTools::UUID.timestamp_create().to_s
      recording_ipi.save!
    end
  end
end
