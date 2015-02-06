class CreateCmsSections < ActiveRecord::Migration
  def change
    create_table :cms_sections do |t|
      t.belongs_to :cms_page, index: true
      t.integer :position
      t.integer :column_nr
      t.string :cms_type
      t.references :cms_module, polymorphic: true, index: true

      t.timestamps
    end
  end
end
