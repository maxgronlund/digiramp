class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.text     "audio_upload"
      t.timestamps
    end
  end
end
