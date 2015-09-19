class UpdateIpisV2 < ActiveRecord::Migration
  def up
    #add_column :common_work_ipis, :lyric, :boolean
    #add_column :common_work_ipis, :music, :boolean
    #add_column :common_work_ipis, :melody, :boolean
    #add_column :common_work_ipis, :arrangement, :boolean
    #add_column :common_work_ipis, :share, :decimal
    #add_column :common_work_ipis, :show_on_recordings, :boolean
    #add_column :common_work_ipis, :status, :integer
    #add_column :common_work_ipis, :notes, :text
    #add_column :common_work_ipis, :ascap_work_id, :integer
    #add_column :common_work_ipis, :bmi_work_id, :integer
    #add_column :common_work_ipis, :email, :string
    #add_column :common_work_ipis, :alias, :string
    #add_column :common_work_ipis, :full_name, :string
    add_column :ipis, :master_ipi, :boolean, default: false

    bad_ipis = []
    good_ipis = []
    Ipi.find_each do |ipi|
      if  (ipi.email.to_s == "" || ipi.email.to_s == " ")  &&
          ipi.ipi_code.nil?     &&
          ipi.cae_code.nil?     &&
          ipi.user_id.nil?      && 
          
        bad_ipis << ipi  
      else
        if CommonWork.exists?( ipi.common_work_id )
          good_ipis << ipi
        else
          bad_ipis << ipi
        end
      end
    end

    
    create_common_work_ipis good_ipis
    set_master_ips good_ipis

    
    update_common_work_ipis
    set_address__on_master_ipis

  end
  
  def down
    remove_column :ipis, :master_ipi, :boolean, default: false
    CommonWorkIpi.destroy_all
    
    #remove_column :common_work_ipis, :lyric, :boolean
    #remove_column :common_work_ipis, :music, :boolean
    #remove_column :common_work_ipis, :melody, :boolean
    #remove_column :common_work_ipis, :arrangement, :boolean
    #remove_column :common_work_ipis, :share, :decimal
    #remove_column :common_work_ipis, :show_on_recordings, :boolean
    #remove_column :common_work_ipis, :status, :integer
    #remove_column :common_work_ipis, :notes, :text
    #remove_column :common_work_ipis, :ascap_work_id, :integer
    #remove_column :common_work_ipis, :bmi_work_id, :integer
    #remove_column :common_work_ipis, :email, :string
    #remove_column :common_work_ipis, :alias, :string
    #remove_column :common_work_ipis, :full_name, :string
    remove_column :ipis, :master_ipi, :boolean, default: false
  end
  
  
  
  def create_common_work_ipis good_ipis

    good_ipis.each do |ip|
      CommonWorkIpi.where(common_work_id: ip.common_work_id, ipi_id: ip.id )
                   .first_or_create(common_work_id: ip.common_work_id, ipi_id: ip.id )
    end

  end
  
  def set_master_ips good_ipis
    
    good_ipis.each do |ipi|
      
      # merge ips with the same email
      if dublets = Ipi.where(email: ipi.email)
        unless dublets.find_by(master_ipi: true)
          dublets.first.update(master_ipi: true)
        end
      end
    end
  end
  
  # make sure only master_ipis are attached
  def update_common_work_ipis
    CommonWorkIpi.find_each do |common_work_ipi|
      ipi = common_work_ipi.ipi
      if master_ipi = Ipi.where(email: ipi.email, master_ipi: true ).first
        common_work_ipi.update(ipi_id: master_ipi.id)
      end
    end
  end
  
  
  def set_address__on_master_ipis
    Ipi.where( master_ipi: true ).each do |ipi|
      if user = ipi.user
        user.copy_address_to( ipi.address )
        ipi.update(ipi_code: user.ipi_code) if (ipi.ipi_code.nil?)
      end
    end
  end
  
 
end
