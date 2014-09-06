class CreateFobars < ActiveRecord::Migration
  def change
    create_table :fobars do |t|
      t.string :index

      t.timestamps
    end
  end
end
