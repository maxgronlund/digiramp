class AddTemplateIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :template_id, :integer
  end
end
