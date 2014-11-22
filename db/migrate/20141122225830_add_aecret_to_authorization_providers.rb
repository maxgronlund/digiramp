class AddAecretToAuthorizationProviders < ActiveRecord::Migration
  def change
    add_column :authorization_providers, :oauth_secret, :string
  end
end
