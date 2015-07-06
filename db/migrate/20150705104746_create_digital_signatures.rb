class CreateDigitalsignatures < ActiveRecord::Migration
  def change
    create_table :digital_signatures do |t|
      t.string :uuid
      t.belongs_to :user, index: true
      t.belongs_to :account, index: true, foreign_key: true , on_delete: :cascade
      t.references :document, polymorphic: true, index: true
      t.string :image

      t.timestamps null: false
    end
  end
end
