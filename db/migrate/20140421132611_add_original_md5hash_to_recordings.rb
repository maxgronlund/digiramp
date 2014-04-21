class AddOriginalMd5hashToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :original_md5hash, :string, default: ''
    Recording.all.each do |recording|
      recording.original_md5hash = UUIDTools::UUID.random_create().to_s
      recording.save!
    end
  end
end
