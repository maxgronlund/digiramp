class UpdateConfOnAllUsers < ActiveRecord::Migration
  def change
    UserConfiguration.update_all(status: 0)
  end
end
