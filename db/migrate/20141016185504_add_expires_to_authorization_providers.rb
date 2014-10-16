class AddExpiresToAuthorizationProviders < ActiveRecord::Migration
  def change
    add_column :authorization_providers, :oauth_expires, :boolean
  end
end
