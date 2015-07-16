class CreateAdminLegalTags < ActiveRecord::Migration
  def change
    create_table :admin_legal_tags do |t|
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
