class AddRoyaltyToCommonWorks < ActiveRecord::Migration
  def change
    add_column :common_works, :royalty, :integer, default: 10
    
    CommonWork.update_all(royalty: 10)
  end
end
