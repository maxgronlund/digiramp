class CreateZipFiles < ActiveRecord::Migration
  def change
    create_table :zip_files do |t|
      t.string :identifier
      t.string :title
      t.text :body
      t.string :zip_file

      t.timestamps
    end
  end
end
