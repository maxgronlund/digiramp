class AddSocialNamesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :link_to_facebook, :string       , default: ''
    add_column :users, :link_to_twitter, :string        , default: ''
    add_column :users, :link_to_linkedin, :string       , default: ''
    add_column :users, :link_to_google_plus, :string    , default: ''
  end
end
