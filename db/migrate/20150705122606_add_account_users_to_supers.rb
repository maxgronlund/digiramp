class AddAccountUsersToSupers < ActiveRecord::Migration
  def change
    Superuserservice.doit
  end
end
