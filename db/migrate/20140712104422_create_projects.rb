class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.belongs_to :account, index: true
      t.belongs_to :user, index: true
      t.string :user_uuid
      t.string :title
      t.text :descriprion
      t.string :category
      t.string :stage

      t.timestamps
    end
  end
end
