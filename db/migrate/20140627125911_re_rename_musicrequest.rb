class ReRenameMusicrequest < ActiveRecord::Migration
  def up
    add_column    :music_requests, :opportunity_id, :integer
    add_index     :music_requests, :opportunity_id
  end
  
  def down
    remove_column :music_requests, :opportunity_id
    add_column    :music_requests, :music_oppertunity_id, :integer
    add_index     :music_requests, :music_oppertunity_id
  end
end
