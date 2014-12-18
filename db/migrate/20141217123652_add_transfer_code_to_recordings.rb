class AddTransferCodeToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :transfer_code, :string
    add_column :recordings, :transferable, :boolean, default: false
    
    Recording.find_each do |recording|
      recording.transfer_code = UUIDTools::UUID.timestamp_create().to_s
      recording.transferable  = false
      recording.save
    end
  end
end
