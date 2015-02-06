class CreateCmsVerticalLinks < ActiveRecord::Migration
  def change
    create_table :cms_vertical_links do |t|
      t.timestamps
    end
  end
end
