class SetDefaultValuesOnRecordings < ActiveRecord::Migration
  def change
    change_column :recordings, :copyright, :string, default: ''
    change_column :recordings, :year, :string, default: ''
    change_column :recordings, :title, :string, default: 'no title'
  end
end


