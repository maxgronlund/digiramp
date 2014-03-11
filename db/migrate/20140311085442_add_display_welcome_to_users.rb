class AddDisplayWelcomeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :show_welcome_message, :boolean, default: true
  end
end
