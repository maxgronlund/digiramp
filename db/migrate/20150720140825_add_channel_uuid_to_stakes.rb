class AddChannelUuidToStakes < ActiveRecord::Migration
  def change
    add_column :stakes, :channel_uuid, :string
  end
end
