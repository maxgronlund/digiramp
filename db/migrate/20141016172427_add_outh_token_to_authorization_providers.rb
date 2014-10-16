class AddOuthTokenToAuthorizationProviders < ActiveRecord::Migration
  def change
    add_column :authorization_providers, :oauth_token, :string
    add_column :authorization_providers, :oauth_expires_at, :datetime
  end
end
