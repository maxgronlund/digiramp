class CreateCmsRecordings < ActiveRecord::Migration
  def change
    create_table :cms_recordings do |t|
      t.belongs_to :recording, index: true

      t.timestamps
    end
  end
end
