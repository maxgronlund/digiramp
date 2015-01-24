class RenameTeaserOnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :teaser, :short_description
  end
end
