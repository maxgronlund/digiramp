class AddSignatureToDigitalSignatures < ActiveRecord::Migration
  def change
    add_column :digital_signatures, :signature, :string
    add_column :digital_signatures, :font, :string
  end
end
