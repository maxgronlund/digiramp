class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :title
      t.text :subject

      t.timestamps
    end
  end
end
