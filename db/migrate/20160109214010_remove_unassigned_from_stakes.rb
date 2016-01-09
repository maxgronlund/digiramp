class RemoveUnassignedFromStakes < ActiveRecord::Migration
  def change
    remove_column :stakes, :unassigned
  end
end
