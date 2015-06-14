class RemoveSuperusersFromAccounts < ActiveRecord::Migration
  def change
    AccountUser.where(role: "Super User").destroy_all
  end
end
