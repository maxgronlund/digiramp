class CreateImageFiles < ActiveRecord::Migration
  def change
    create_table :image_files do |t|
      t.string :title
      t.text :body
      t.belongs_to :account, index: true
      t.string :file

      t.timestamps
    end
  end
end
