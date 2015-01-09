class AddQouteToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :qoute_id, :integer
    
    add_index :replies, :qoute_id
  end
end
