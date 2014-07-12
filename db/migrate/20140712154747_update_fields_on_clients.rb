class UpdateFieldsOnClients < ActiveRecord::Migration
  def change
    Client.destroy_all
    add_column :clients, :assistant, :string, default: ''
    add_column :clients, :direct_phone, :string, default: ''
    add_column :clients, :direct_fax, :string, default: ''
    add_column :clients, :business_email, :string, default: ''
    rename_column :clients, :telephone_work,  :business_phone
    rename_column :clients, :fax_work, :business_fax
  end
end
