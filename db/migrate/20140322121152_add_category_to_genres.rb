class AddCategoryToGenres < ActiveRecord::Migration
  def change
    add_column :genres, :category, :string, default: 'other'
  end
end
