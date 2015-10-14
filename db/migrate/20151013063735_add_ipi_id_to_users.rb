class AddIpiIdToUsers < ActiveRecord::Migration
  def change

    User.find_each do |user|
      unless user.ipi
        ap '============================== no ipi =================================='
        begin
          ipi = Ipi.create(
            user_id:    user.id, 
            master_ipi: true,
            uuid:       UUIDTools::UUID.timestamp_create().to_s,
            email:      user.seller_info[:email],
            full_name:  user.full_name
          )
          ipi.accepted!
        rescue => e
          
          ap '================================================================'
          ap e.inspect
          ap user.seller_info[:email]
          ap user.update(email: user.seller_info[:email])
          ipi = Ipi.create(
            user_id:    user.id, 
            master_ipi: true,
            uuid:       UUIDTools::UUID.timestamp_create().to_s,
            email:      user.seller_info[:email],
            full_name:  user.full_name
          )
          ipi.accepted!
        end
        
        ap user.ipi
      end
    end
  end
end
