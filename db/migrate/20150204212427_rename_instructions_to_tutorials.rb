class RenameInstructionsToTutorials < ActiveRecord::Migration
  def change
    rename_table :instructions, :tutorials
  end
end
