class CreateDefaultImages < ActiveRecord::Migration
  def change
    create_table :default_images do |t|
      t.string :recording_artwork
      t.string :user_avatar
      t.string :company_logo

      t.timestamps
    end
  end
end
