class CreateRawImages < ActiveRecord::Migration
  def change
    create_table :raw_images do |t|
      t.string :identifier
      t.string :title
      t.string :image

      t.timestamps
    end
  end
end
