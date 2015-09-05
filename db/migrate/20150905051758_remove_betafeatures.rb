class RemoveBetafeatures < ActiveRecord::Migration
  def change
    remove_column :users, :betatester
  end
end
