class RemovePermittedUserIdsFromAccounts < ActiveRecord::Migration
  def up
    remove_column :accounts, :permitted_user_ids
  end
end
