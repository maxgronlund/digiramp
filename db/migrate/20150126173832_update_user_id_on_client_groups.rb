class UpdateUserIdOnClientGroups < ActiveRecord::Migration
  def change
    ClientGroup.find_each do |client_group|
      if user = User.where(uuid: client_group.user_uuid).first
        client_group.user_id = user.id
        client_group.save!
      else
        puts '-----------autch-------------'
        puts client_group.id
      end
    end
  end
end
