class AddSublimeVideoFormatsToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :mp4_360_p, :string
    add_column :videos, :mp4_720_p, :string
    add_column :videos, :webm_360_p, :string
    add_column :videos, :webm_720_p, :string
  end
end
