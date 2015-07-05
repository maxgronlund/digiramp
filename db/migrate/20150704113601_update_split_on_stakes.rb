class UpdateSplitOnStakes < ActiveRecord::Migration
  def change
    rename_column :stakes, :split_in_percent, :split
    rename_column :stakes, :email_for_missing_user, :email
    remove_column :stakes, :user_id
  end
end
