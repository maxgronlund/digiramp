class AddThumbnailToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :thumbnail, :string
  end
end
