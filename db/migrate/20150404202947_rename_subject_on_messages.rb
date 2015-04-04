class RenameSubjectOnMessages < ActiveRecord::Migration
  def change
    rename_column :messages, :subjebtable_id, :subjectable_id
    rename_column :messages, :subjebtable_type, :subjectable_type
  end
end
