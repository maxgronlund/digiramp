class CreateAmazonSns < ActiveRecord::Migration
  def change
    create_table :amazon_sns do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
