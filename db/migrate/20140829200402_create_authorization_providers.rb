class CreateAuthorizationProviders < ActiveRecord::Migration
  def change
    create_table :authorization_providers do |t|
      t.string :provider
      t.string :uid
      #t.string :name
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
