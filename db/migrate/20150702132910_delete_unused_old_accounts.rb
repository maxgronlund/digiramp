class DeleteUnusedOldAccounts < ActiveRecord::Migration
  def change
    account = Account.find(8)
    account.destroy
    Recording.where(account_id: 139).update_all(account_id: 333)
    CommonWork.where(account_id: 139).update_all(account_id: 333)

  end
end
