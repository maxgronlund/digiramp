class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :title
      t.text :body
      t.string :image
      t.belongs_to :user, index: true
      t.string :os
      t.string :browser
      t.string :link_to_page
      t.string :can_reproducd
      t.string :status
      t.string :priority
      t.string :symtom

      t.timestamps
    end
  end
end
