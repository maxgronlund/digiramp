class AddShowAlertToClient < ActiveRecord::Migration
  def change
    add_column :clients, :show_alert, :boolean, default: false
  end
end
