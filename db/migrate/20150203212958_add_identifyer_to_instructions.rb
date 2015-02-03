class AddIdentifyerToInstructions < ActiveRecord::Migration
  def change
    add_column :instructions, :identifier, :string
    add_column :instructions, :duration, :string
  end
end
