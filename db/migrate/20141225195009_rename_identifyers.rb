class RenameIdentifyers < ActiveRecord::Migration
  def change
    rename_column :digiramp_ads, :identifyer, :identifier
  end
end
