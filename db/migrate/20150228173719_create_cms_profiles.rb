class CreateCmsProfiles < ActiveRecord::Migration
  def change
    create_table :cms_profiles do |t|
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
