class CreateContacts < ActiveRecord::Migration
  def change
    drop_table :contacts
    create_table :contacts do |t|
      t.string :email
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
