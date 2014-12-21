class CreateHelps < ActiveRecord::Migration
  def change
    create_table :helps do |t|
      t.string :identifier
      t.string :button
      t.string :title
      t.text :body
      t.text :snippet

      t.timestamps
    end
  end
end
