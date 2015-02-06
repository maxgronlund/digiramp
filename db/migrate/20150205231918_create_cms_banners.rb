class CreateCmsBanners < ActiveRecord::Migration
  def change
    create_table :cms_banners do |t|
      t.string :image
      t.string :size
      t.timestamps
    end
  end
end
