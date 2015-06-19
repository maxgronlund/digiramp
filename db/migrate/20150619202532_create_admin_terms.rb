class CreateAdminTerms < ActiveRecord::Migration
  def change
    create_table :admin_terms do |t|
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end
