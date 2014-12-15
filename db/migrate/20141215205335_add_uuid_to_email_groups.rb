class AddUuidToEmailGroups < ActiveRecord::Migration
  def change
    add_column :email_groups, :uuid, :string
  end
end
