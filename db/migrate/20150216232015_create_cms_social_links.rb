class CreateCmsSocialLinks < ActiveRecord::Migration
  def change
    create_table :cms_social_links do |t|
      t.integer :position
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
