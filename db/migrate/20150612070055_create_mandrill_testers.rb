class CreateMandrillTesters < ActiveRecord::Migration
  def change
    create_table :mandrill_testers do |t|
      t.string :email
      t.string :subject
      t.text :message

      t.timestamps null: false
    end
  end
end
