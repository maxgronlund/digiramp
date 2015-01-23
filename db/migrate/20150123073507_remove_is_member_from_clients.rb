class RemoveIsMemberFromClients < ActiveRecord::Migration
  def change
    remove_column :clients, :is_member
  end
end
