class CleanupInstruments < ActiveRecord::Migration
  def change
    
    add_column :instruments, :recordings_count, :integer, default: 0
    add_column :moods, :recordings_count, :integer, default: 0

  end
end
