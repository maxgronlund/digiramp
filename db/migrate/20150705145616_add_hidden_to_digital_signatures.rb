class AddHiddenToDigitalSignatures < ActiveRecord::Migration
  def change
    add_column :digital_signatures, :hidden, :boolean, default: false
  end
end
