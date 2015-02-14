class CatalogsDocuments < ActiveRecord::Base
  belongs_to :catalog
  belongs_to :documents
end
