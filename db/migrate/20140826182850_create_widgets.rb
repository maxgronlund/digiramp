class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :title
      t.text :body
      t.string :image
      t.string :secret_key
      t.integer :width, default: 480
      t.integer :height, default: 640
      t.string :layout
      t.belongs_to :user, index: true
      t.belongs_to :account, index: true
      t.belongs_to :catalog, index: true

      t.timestamps
    end
  end
end
