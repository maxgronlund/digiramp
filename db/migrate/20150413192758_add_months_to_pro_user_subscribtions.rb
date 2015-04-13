class AddMonthsToProUserSubscribtions < ActiveRecord::Migration
  def change
    add_column :pro_user_subscribtions, :months, :integer
  end
end
