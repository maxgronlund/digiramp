class CreateCatalogUsers < ActiveRecord::Migration
  def change
    create_table :catalog_users do |t|
      t.belongs_to :catalog, index: true
      t.belongs_to :user, index: true
      t.belongs_to :account, index: true
      t.string :email                           , default: ''
      t.string :title                           , default: ''
      t.text :body                              , default: ''
      t.boolean :can_edit                       , default: false
      t.boolean :access_files                   , default: false
      t.boolean :access_legal_documents         , default: false
      t.boolean :access_financial_documents     , default: false
      t.boolean :access_ipis                    , default: false

      t.timestamps
    end
  end
end
