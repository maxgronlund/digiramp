class AddComposerToRecordings < ActiveRecord::Migration
  def change
    add_column :recordings, :composer, :string, default: ''
  end
end
