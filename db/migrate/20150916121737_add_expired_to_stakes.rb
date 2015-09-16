class AddExpiredToStakes < ActiveRecord::Migration
  def change
    add_column :stakes, :expired, :boolean, default: false
    Stake.update_all(expired: false)
  end
end
