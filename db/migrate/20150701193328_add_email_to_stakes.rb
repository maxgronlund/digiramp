class AddEmailToStakes < ActiveRecord::Migration
  def change
    add_column :stakes, :email_for_missing_user, :string
    add_column :stakes, :unassigned, :boolean, default: false
  end
end
