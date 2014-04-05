class CreateGenreImports < ActiveRecord::Migration
  def change
    create_table :genre_imports do |t|
      t.string :csv_file

      t.timestamps
    end
  end
end
