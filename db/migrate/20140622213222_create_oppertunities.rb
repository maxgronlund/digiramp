class CreateOppertunities < ActiveRecord::Migration
  def change
    
    drop_table :music_opportunities
    
    create_table :oppertunities do |t|
      t.string :title
      t.text :body
      t.string :kind
      t.decimal :budget
      t.date :deadline
      t.belongs_to :account, index: true
    
      t.timestamps
    end
  end
end
