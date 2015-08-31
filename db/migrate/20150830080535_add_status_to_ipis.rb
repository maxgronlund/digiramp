class AddStatusToIpis < ActiveRecord::Migration
  def change
    add_column :ipis, :status, :integer
    
    Ipi.find_each do |ipi|
      if ipi.email.blank? && ipi.user.blank?
        if user = ipi.user
          ipi.update(email: user.email)
        end
      end
      

      if ipi.confirmation == 'Missing' || ipi.confirmation.blank?
        ipi.status = 0
        ipi.save(validate: false)
      end
      
    end
    
    #remove_column :ipis, :address
  end
end
