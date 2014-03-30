class AddUuidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :uuid, :string, default: ''
    
    User.all.each do |user|
      user.uuid = UUIDTools::UUID.random_create().to_s
      if user.name.nil?
        user.name = user.email
      end
      user.save!
    end
  end
end
