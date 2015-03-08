class AddNewsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :news_count, :integer, default: 0
  end
end
