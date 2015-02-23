class CreateTutorialViews < ActiveRecord::Migration
  def change
    create_table :tutorial_views do |t|
      t.belongs_to :tutorial, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
