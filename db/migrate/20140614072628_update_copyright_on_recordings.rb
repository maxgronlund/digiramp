class UpdateCopyrightOnRecordings < ActiveRecord::Migration
  def change
    change_column :recordings, :copyright, :text, default: ''
    change_column :recordings, :composer, :text, default: ''
    change_column :recordings, :band, :text, default: ''
  end
end
