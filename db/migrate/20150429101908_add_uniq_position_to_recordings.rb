class AddUniqPositionToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :uniq_position, :string
    
    Recording.find_each do |recording|
      recording.position      = recording.id if recording.position.blank?
      recording.uniq_position = recording.position.to_uniq
      recording.save!
    end
    
    
  end
end
