class RemoveComonWorkImport < ActiveRecord::Migration
  def change
    drop_table :common_work_imports
    add_column :common_works_imports, :pro, :string
    add_column :common_works_imports, :user_email, :string
  end
end
