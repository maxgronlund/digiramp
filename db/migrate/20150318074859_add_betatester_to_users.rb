class AddBetatesterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :betatester, :boolean
  end
end
