class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.integer :version

      t.timestamps
    end
    Admin.create(version: 0)
  end
end
