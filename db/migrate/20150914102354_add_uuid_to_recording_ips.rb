class AddUuidToRecordingIps < ActiveRecord::Migration
  def change
    
    add_column :stakes, :ip_uuid, :uuid
    add_column :stakes, :ip_type, :string
    Stake.destroy_all
    
   
  end
end
