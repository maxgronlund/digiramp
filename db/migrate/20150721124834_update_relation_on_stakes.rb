class UpdateRelationOnStakes < ActiveRecord::Migration
  def change
    Stake.destroy_all
    remove_column :stakes, :asset_id
    remove_column :stakes, :asset_type
    add_reference :stakes, :asset, index: true, polymorphic: true, type: :uuid

    
  end
end
