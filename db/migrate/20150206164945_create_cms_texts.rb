class CreateCmsTexts < ActiveRecord::Migration
  def change
    create_table :cms_texts do |t|
      t.integer :position
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
