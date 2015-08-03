class CreateMusicSubmissionSelections < ActiveRecord::Migration
  def change
    create_table :music_submission_selections do |t|
      t.belongs_to :account, index: true, foreign_key: false
      t.belongs_to :music_submission, index: true, foreign_key: false
      t.belongs_to :music_request, index: true, foreign_key: false
      t.belongs_to :user, index: true, foreign_key: false

      t.timestamps null: false
    end
    
    add_foreign_key "music_submission_selections", "music_submissions", on_delete: :cascade
    add_foreign_key "music_submission_selections", "music_requests",    on_delete: :cascade
    
  end
end
