class AddCategoryToInstruments < ActiveRecord::Migration
  def change
    add_column :instruments, :category, :string, default: "other"
  end
end
