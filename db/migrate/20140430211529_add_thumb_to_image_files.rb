class AddThumbToImageFiles < ActiveRecord::Migration
  def change
    add_column :image_files, :thumb, :string
  end
end
