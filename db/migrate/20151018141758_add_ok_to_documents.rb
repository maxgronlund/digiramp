class AddOkToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :ok, :boolean
  end
end
