class AddContactSubjectToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :contact_subject, :string, default: 'contact'
  end
end
