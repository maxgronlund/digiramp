class CreateClientGroupsClients < ActiveRecord::Migration
  def change
    create_table :client_groups_clients do |t|
      t.belongs_to :client_group, index: true
      t.belongs_to :client, index: true

      t.timestamps
    end
  end
end
