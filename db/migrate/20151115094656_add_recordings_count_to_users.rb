class AddRecordingsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_recordings, :boolean
    add_column :users, :provide_to_opportunity, :boolean
    add_column :users, :review_opportunity, :boolean
    add_column :users, :follow_other_users, :boolean
    add_column :users, :has_liked_recordings, :boolean
    
    User.find_each do |user|
      user.update_columns(
        has_recordings:  user.recordings.count > 0,
        provide_to_opportunity:   user.opportunity_users.where(provider: true).count > 0 ,
        review_opportunity:       user.opportunity_users.where(reviewer: true).count > 0 ,
        follow_other_users:        user.relationships.count > 0 ,
        has_liked_recordings:     user.likes.count > 0 
      )
    end
  end
end
