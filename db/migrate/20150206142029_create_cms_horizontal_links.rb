class CreateCmsHorizontalLinks < ActiveRecord::Migration
  def change
    create_table :cms_horizontal_links do |t|
      t.timestamps
    end
  end
end
