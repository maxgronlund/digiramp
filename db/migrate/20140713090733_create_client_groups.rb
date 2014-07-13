class CreateClientGroups < ActiveRecord::Migration
  def change
    create_table :client_groups do |t|
      t.string :title
      t.belongs_to :account, index: true

      t.timestamps
    end
  end
end
