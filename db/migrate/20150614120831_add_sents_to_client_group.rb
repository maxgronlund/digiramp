class AddSentsToClientGroup < ActiveRecord::Migration
  def change
    add_column :client_groups, :sents, :integer, default: 0
    add_column :client_groups, :opens, :integer, default: 0
  end
end
