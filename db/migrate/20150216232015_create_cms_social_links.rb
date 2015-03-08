class CreateCmsSocialLinks < ActiveRecord::Migration
  def change
    create_table :cms_social_links do |t|
      t.timestamps
    end
  end
end
