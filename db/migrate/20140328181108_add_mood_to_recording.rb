class AddMoodToRecording < ActiveRecord::Migration
  def change
    add_column :recordings, :mood, :string ,          default: ''
    add_column :recordings, :instruments, :string,    default: ''
    add_column :recordings, :tempo, :string,          default: ''
  end
end
