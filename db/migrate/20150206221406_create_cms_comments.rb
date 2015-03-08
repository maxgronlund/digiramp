class CreateCmsComments < ActiveRecord::Migration
  def change
    create_table :cms_comments do |t|
      t.integer :position

      t.timestamps
    end
  end
end
