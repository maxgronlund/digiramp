class RecreateForumReplies < ActiveRecord::Migration

  def change
    drop_table :forum_replies
    
    create_table :replies do |t|
      t.string :title
      t.text :body
      t.belongs_to :user, index: true
      t.references :replyable, polymorphic: true, index: true
  
      t.timestamps
    end

  end
end
