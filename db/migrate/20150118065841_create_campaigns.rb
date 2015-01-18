class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.text :body
      t.belongs_to :user, index: true
      t.belongs_to :account, index: true
      t.string :status
      t.text :emails

      t.timestamps
    end
  end
end
