class CreateMoodsImports < ActiveRecord::Migration
  def change
    create_table :moods_imports do |t|
      t.string :csv_file

      t.timestamps
    end
  end
end
