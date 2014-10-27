class CreateShareOnFacebooks < ActiveRecord::Migration
  def change
    create_table :share_on_facebooks do |t|
      t.belongs_to :user, index: true
      t.belongs_to :recording, index: true
      t.text :message

      t.timestamps
    end
  end
end
