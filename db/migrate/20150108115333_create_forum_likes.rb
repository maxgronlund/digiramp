class CreateForumLikes < ActiveRecord::Migration
  def change
    create_table :forum_likes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :forum_post, index: true

      t.timestamps
    end
  end
end
