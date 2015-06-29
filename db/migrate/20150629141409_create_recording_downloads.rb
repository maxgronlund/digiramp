class CreateRecordingDownloads < ActiveRecord::Migration
  def change
    create_table :recording_downloads do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :recording, index: true, foreign_key: true
      t.integer :downloads
      t.string :uuid
      t.belongs_to :shop_order_item, index: true, foreign_key: true
      t.belongs_to :shop_product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
