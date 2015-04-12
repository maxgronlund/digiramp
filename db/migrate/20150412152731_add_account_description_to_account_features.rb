class AddAccountDescriptionToAccountFeatures < ActiveRecord::Migration
  def change
    add_column :account_features, :description, :text, default: ''
    add_column :registrations, :description, :text, default: ''
  end
end
