class CreateCmsPages < ActiveRecord::Migration
  def change
    create_table :cms_pages do |t|
      t.belongs_to :user, index: true
      t.string :title

      t.timestamps
    end
  end
end
