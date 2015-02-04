class AddShowIntroductionToUsers < ActiveRecord::Migration
  def change
    add_column :users, :show_introduction, :boolean, default: false
  end
end
