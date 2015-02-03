class AddPublishedToInstructions < ActiveRecord::Migration
  def change
    add_column :instructions, :published, :boolean      , default: false
    add_column :instructions, :pro_account, :boolean    , default: false
    add_column :instructions, :super, :boolean          , default: false
    change_column :instructions, :video, :text
    add_column :instructions, :thumbnail, :text         , default: ''
  end
end
