class UpdateMasterIpisOnUsers < ActiveRecord::Migration
  def change
    
    User.find_each do |user|
      if ipis = user.ipis
        ap "create for user with ipis #{user.user_name}"
        ipis.where( user_id: user.id,  master_ipi: true)
          .first_or_create(
            user_id:    user.id, 
            master_ipi: true,
            uuid:       UUIDTools::UUID.timestamp_create().to_s,
            email:      user.email,
            full_name:  user.full_name
          )
      else
        ap "create for user without any ipis #{user.user_name}"
        Ipi.create(
          user_id:    user.id, 
          master_ipi: true,
          uuid:       UUIDTools::UUID.timestamp_create().to_s,
          email:      user.email,
          full_name:  user.full_name
        )
      end
    end
  end
end
