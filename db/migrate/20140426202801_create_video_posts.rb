class CreateVideoPosts < ActiveRecord::Migration
  def change
    create_table :video_posts do |t|
      t.string :title
      t.text :body
      t.text :transloadet
      t.string :file
      t.string :thumb
      t.string :uuid
      t.string :mp4_video
      t.string :webm_video

      t.timestamps
    end
  end
end
