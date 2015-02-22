class CreateUserCmsContacts < ActiveRecord::Migration
  def change
    create_table :cms_contacts do |t|
      t.string :message

      t.timestamps
    end
  end
end
