class AddUuidToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :uuid, :uuid
  end
end
