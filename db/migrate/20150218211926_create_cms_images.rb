class CreateCmsImages < ActiveRecord::Migration
  def change
    create_table :cms_images do |t|
      t.string :image
      t.string :caption


      t.timestamps
    end
  end
end
