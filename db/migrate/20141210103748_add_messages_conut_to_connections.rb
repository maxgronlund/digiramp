class AddMessagesConutToConnections < ActiveRecord::Migration
  def change
    add_column :connections, :messages_count, :integer, default: 0
  end
end
