class AddProToIpis < ActiveRecord::Migration
  def change
    add_column :ipis, :pro, :string
    add_column :ipis, :has_agreement, :boolean
    add_column :ipis, :linked_to_ascap_member, :boolean
    add_column :ipis, :controlled_by_submitter, :boolean

  end
end
