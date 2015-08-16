class AddTransferUuidToPublishers < ActiveRecord::Migration
  def change
    add_column :publishers, :transfer_uuid, :uuid
  end
end
