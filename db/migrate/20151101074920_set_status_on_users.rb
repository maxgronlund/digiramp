class SetStatusOnUsers < ActiveRecord::Migration
  def change
    User.where(status: nil).update_all(status: 0)
  end
end
