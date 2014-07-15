class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.belongs_to :opportunity, index: true
      t.belongs_to :account, index: true
      t.belongs_to :user, index: true
      t.belongs_to :recording, index: true
      t.string :title
      t.text :body
      t.integer :rating

      t.timestamps
    end
  end
end