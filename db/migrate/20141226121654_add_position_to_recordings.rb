class AddPositionToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :position, :integer, default: 0
    
    
    Account.find_each do |account|
      account.recordings.each_with_index do |rec, index|
        rec.position = index
        rec.save!
      end
      
    end
  end
end
