class AddStatusToRecordints < ActiveRecord::Migration
  def change
    add_column :recordings, :status, :string, default: 'PLAY'
  end
end
