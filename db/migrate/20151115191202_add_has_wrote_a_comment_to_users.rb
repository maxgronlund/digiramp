class AddHasWroteACommentToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_wrote_a_recording_comment, :boolean
    add_column :users, :has_wrote_a_user_comment, :boolean
    add_column :users, :has_wrote_a_playlist_comment, :boolean
    add_column :users, :has_liked_a_user, :boolean
    
    User.find_each do |user|
      user.update_columns(
        has_wrote_a_recording_comment:    Comment.where(user_id: user.id, commentable_type: 'Recording').count > 0,
        has_wrote_a_user_comment:         Comment.where(user_id: user.id, commentable_type: 'User').count > 0,
        has_wrote_a_playlist_comment:     Comment.where(user_id: user.id, commentable_type: 'Playlist').count > 0,
        has_liked_a_user:                 user.item_likes.where(like_type: 'User').count > 0
      )
    end
    
    
  end
end
