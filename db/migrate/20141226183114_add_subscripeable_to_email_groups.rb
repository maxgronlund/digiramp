class AddSubscripeableToEmailGroups < ActiveRecord::Migration
  def change
    add_column :email_groups, :subscripeable, :boolean, default: false
  end
end
