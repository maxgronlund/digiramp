class AddTitleToDefaultImages < ActiveRecord::Migration
  def change
    add_column :default_images, :title, :string
  end
end
