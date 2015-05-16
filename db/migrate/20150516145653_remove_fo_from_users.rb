class RemoveFoFromUsers < ActiveRecord::Migration
  def change
    begin
      remove_column :users, :fo, :string
    rescue
    end
    
  end
end
