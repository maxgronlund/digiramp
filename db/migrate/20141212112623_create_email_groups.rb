class CreateEmailGroups < ActiveRecord::Migration
  def change
    create_table :email_groups do |t|
      t.string :title, default: ''
      t.text :body, default: ''

      t.timestamps
    end
  end
end
