class CreateBlacklistDomains < ActiveRecord::Migration
  def change
    create_table :blacklist_domains do |t|
      t.string :domain

      t.timestamps null: false
    end
  end
end
