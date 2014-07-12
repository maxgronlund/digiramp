class CreateClientImports < ActiveRecord::Migration
  def change
    create_table :client_imports do |t|
      t.belongs_to :account, index: true
      t.string :user_uuid
      t.string :file

      t.timestamps
    end
  end
end
