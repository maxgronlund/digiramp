class AddLinkToTumblrToUsers < ActiveRecord::Migration
  def change
    add_column :users, :link_to_tumblr, :string       , default: ''
    add_column :users, :link_to_instagram, :string    , default: ''
    add_column :users, :link_to_youtube, :string      , default: ''
    
    User.find_each do |user|
      user.validate_social_links
      user.save!
    end
  end
end
