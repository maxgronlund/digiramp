class UpdateInvitationCountOnClientGroups < ActiveRecord::Migration
  def change
    change_column :client_groups, :invitation_count, :integer, default: 0
    ClientGroup.find_each do |cg|
      if cg.invitation_count.nil?
        cg.invitation_count = 0
        cg.save!
      end
    end
  end
end
