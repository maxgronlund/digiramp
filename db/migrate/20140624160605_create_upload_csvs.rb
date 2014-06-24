class CreateUploadCsvs < ActiveRecord::Migration
  def change
    create_table :upload_csvs do |t|
      t.string :file
      t.string :title
      t.text :body
      t.string :user_email
      t.belongs_to :account, index: true
      t.belongs_to :catalog, index: true
      t.integer :common_works_count

      t.timestamps
    end
  end
end
