class AddProAffiliationIdToIpis < ActiveRecord::Migration
  def change
    add_column :ipis, :pro_affiliation_id, :integer
    add_index :ipis, :pro_affiliation_id
    
    Ipi.find_each do |ipi|
      if ipi.pro && pro = ProAffiliation.where(id: ipi.pro.to_i).first
        ipi.pro_affiliation_id = pro.id
        ipi.save!
      end
    end
    remove_column :ipis, :pro
  end
end
