class AddGenreCategoryToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :genre_category, :string, default: 'other'
    
    
  end
end
