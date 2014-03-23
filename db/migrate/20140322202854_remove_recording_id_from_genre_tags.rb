class RemoveRecordingIdFromGenreTags < ActiveRecord::Migration
  def change
    remove_column :genre_tags, :recording_id
    #drop_table :genre_tags
    
    #create_table "genre_tags", force: true do |t|
    #  t.integer  "genre_id"
    #  t.integer  "recording_id"
    #  t.datetime "created_at",         null: false
    #  t.datetime "updated_at",         null: false
    #  t.integer  "genre_tagable_id"
    #  t.string   "genre_tagable_type"
    #end
    #
    #add_index "genre_tags", ["genre_id"], name: "index_genre_tags_on_genre_id", using: :btree
    #add_index "genre_tags", ["genre_tagable_id", "genre_tagable_type"], name: "by_genre_tagable_id_and_type", using: :btree
    #add_index "genre_tags", ["recording_id"], name: "index_genre_tags_on_recording_id", using: :btree
  end
end
