class CreateCmsVideos < ActiveRecord::Migration
  def change
    create_table :cms_videos do |t|
      t.integer :position
      t.text :snippet

      t.timestamps
    end
  end
end
