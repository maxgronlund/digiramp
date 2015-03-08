class UpdateThumbnaliOnTutorials < ActiveRecord::Migration
  def change
    change_column :tutorials, :thumbnail, :string
  end
end
