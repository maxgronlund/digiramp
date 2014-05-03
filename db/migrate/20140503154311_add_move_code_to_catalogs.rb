class AddMoveCodeToCatalogs < ActiveRecord::Migration
  def change
    add_column :catalogs, :move_code, :string
  end
end
