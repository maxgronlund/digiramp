class AddUuidToLabels < ActiveRecord::Migration
  def change
    #add_column :labels, :uuid, :uuid
    
    Label.find_each do |label|
      label.update(uuid: UUIDTools::UUID.timestamp_create().to_s)
    end
  end
end
