class RemoveMandrillAccounts < ActiveRecord::Migration
  def change
    drop_table :mandrill_accounts
  end
end
