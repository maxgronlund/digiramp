class AddIpiCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ipi_code, :string
  end
end
