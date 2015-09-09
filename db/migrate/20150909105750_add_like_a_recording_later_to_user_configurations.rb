class AddLikeARecordingLaterToUserConfigurations < ActiveRecord::Migration
  def change
    add_column :user_configurations, :like_a_recording_later, :boolean
    add_column :user_configurations, :add_recording_to_a_playlist_later, :boolean
  end
end
