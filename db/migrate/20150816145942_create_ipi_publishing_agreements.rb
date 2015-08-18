class CreateIpiPublishingAgreements < ActiveRecord::Migration
  def change
    create_table :ipi_publishing_agreements do |t|
      t.belongs_to :ipi, index: true, foreign_key: false
      t.belongs_to :publishing_agreement, index: true, foreign_key: false

      t.timestamps null: false
    end
  end
end
