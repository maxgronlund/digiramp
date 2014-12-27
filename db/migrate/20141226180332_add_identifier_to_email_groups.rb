class AddIdentifierToEmailGroups < ActiveRecord::Migration
  def change
    add_column :email_groups, :identifier, :string
  end
end
