class CreateInstrumentImports < ActiveRecord::Migration
  def change
    create_table :instruments_imports do |t|
      t.string :csv_file

      t.timestamps
    end
  end
end
