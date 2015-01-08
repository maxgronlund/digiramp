class CreateForumReplies < ActiveRecord::Migration
  def change
    create_table :forum_replies do |t|
      t.string :title
      t.text :body
      t.belongs_to :user, index: true
      t.references :replyable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
