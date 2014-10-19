class AddInfoToAuthorizationProviders < ActiveRecord::Migration
  def change
    add_column :authorization_providers, :info, :text
  end
end
