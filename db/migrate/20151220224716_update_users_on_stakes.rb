class UpdateUsersOnStakes < ActiveRecord::Migration
  def change
    Stake.find_each do |stake|
      stake.update_user
    end
  end
end
