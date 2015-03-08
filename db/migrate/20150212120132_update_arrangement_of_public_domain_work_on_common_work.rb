class UpdateArrangementOfPublicDomainWorkOnCommonWork < ActiveRecord::Migration
  def up
    remove_column :common_works, :arrangement_of_public_domain_work
    add_column    :common_works, :arrangement, :boolean, default: false
    

  end
  
  def down
  end
end
