class UpdateDistributionAgreementsIndex < ActiveRecord::Migration
  def change
    
    remove_foreign_key "common_work_ipis", "publishing_agreements"
    remove_foreign_key "recording_ipis", "distribution_agreements"
    
    add_foreign_key "common_work_ipis", "publishing_agreements", on_delete: :cascade
    add_foreign_key "recording_ipis", "distribution_agreements", on_delete: :cascade
  end
end
