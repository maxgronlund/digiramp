class UpdateUuidOnRecordings < ActiveRecord::Migration
  def change
    Recording.find_each do |rec|
      rec.update(uuid: UUIDTools::UUID.timestamp_create().to_s) if rec.uuid.blank? 
    end
  end
end
