class AddStateToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :state, :integer, default: 0
  end
end
