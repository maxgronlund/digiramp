class CreateCmsUserActivities < ActiveRecord::Migration
  def change
    create_table :cms_user_activities do |t|
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
