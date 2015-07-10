class AddEmailToDigitalSignatures < ActiveRecord::Migration
  def change
    add_column :digital_signatures, :email, :string
  end
end
