class CreateCommonWorkImports < ActiveRecord::Migration
  def change

    create_table :common_work_imports do |t|
      t.belongs_to :account, index: true
      t.string :user_email
      t.text :result
      t.string :pro

      t.timestamps
    end
  end
end
