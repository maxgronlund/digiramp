class AddDefaultCoverArtToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :default_cover_art, :string, default: ''
    
    Recording.find_each do |recording|
      recording.check_default_image
    end
  end
end
