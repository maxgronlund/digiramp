class AddMiddleNameToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :middle_name, :string
    add_column :professional_infos, :alias, :string
  end
end
