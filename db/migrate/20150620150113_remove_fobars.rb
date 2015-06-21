class RemoveFobars < ActiveRecord::Migration
  def change
    drop_table :fobars
  end
end
