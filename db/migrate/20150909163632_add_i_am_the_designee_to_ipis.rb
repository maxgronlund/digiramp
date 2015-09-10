class AddIAmTheDesigneeToIpis < ActiveRecord::Migration
  def change
    add_column :ipis, :i_am_the_publishing_designee, :boolean, default: false
    
    Ipi.find_each do |ipi|
      ipi.i_am_the_publishing_designee = false
      if user = ipi.user
        if user_address = user.address
          if address = ipi.address
            address  = user_address.clone
            address.save(validate: false)
          end
        end
      end
      ipi.save(validate: false)
    end

  end
end
