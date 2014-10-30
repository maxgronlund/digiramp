class AddPrivacyToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :privacy, :string, default: "Anyone"
    add_column :recordings, :acceptance_of_terms, :boolean
    remove_column :recordings, :published
  end
end
