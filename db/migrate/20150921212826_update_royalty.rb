class UpdateRoyalty < ActiveRecord::Migration
  def change
    remove_column :distribution_agreements, :royalty
    remove_column :common_works, :royalty
    remove_column :publishing_agreements, :mechanical_royalty
  end
end
