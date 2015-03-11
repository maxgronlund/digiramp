class CreatePageStyles < ActiveRecord::Migration
  def change
    create_table :page_styles do |t|
      t.string :title
      t.string :css_tag
      t.string :backdrop_image
      t.boolean :show_backdrop
      t.string :bgcolor

      t.timestamps
    end
  end
end
