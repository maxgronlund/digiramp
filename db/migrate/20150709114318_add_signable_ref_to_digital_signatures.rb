class AddSignableRefToDigitalSignatures < ActiveRecord::Migration
  def change
    add_reference :digital_signatures, :signable, polymorphic: true, index: true
    add_column :digital_signatures, :role, :string, default: ''
  end
end
