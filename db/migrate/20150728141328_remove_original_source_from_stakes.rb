class RemoveOriginalSourceFromStakes < ActiveRecord::Migration
  def change
    remove_column :stakes, :original_source
    remove_column :stakes, :ipiable_id
    remove_column :stakes, :ipiable_type   
  end
end
