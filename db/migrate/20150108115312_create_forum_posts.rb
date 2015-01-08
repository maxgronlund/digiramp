class CreateForumPosts < ActiveRecord::Migration
  def change
    create_table :forum_posts do |t|
      t.string :title
      t.text :body
      t.string :image
      t.belongs_to :user, index: true
      t.belongs_to :forum, index: true
      t.string :uniq_likes
      t.boolean :published

      t.timestamps
    end
  end
end
