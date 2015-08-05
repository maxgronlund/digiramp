class AddOpportunityUserToMusicSubmissionSelections < ActiveRecord::Migration
  def change
    add_reference :music_submission_selections, :opportunity_user, index: true, foreign_key: false
    
    add_foreign_key "music_submission_selections", "opportunity_users", on_delete: :cascade
    
    MusicSubmissionSelection.destroy_all
    
  end
end
