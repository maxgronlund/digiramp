class AddHasACollectionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :has_a_collection, :boolean, default: true
    
    User.update_all(has_a_collection: true)
    
    #User.all.each do |user|
    #  user.save!
    #end
  end
end
