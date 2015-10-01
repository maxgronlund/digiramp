class CreateIpiPublishers < ActiveRecord::Migration
  def change
    create_table :ipi_publishers do |t|
      t.belongs_to :ipi, index: true, foreign_key: false
      t.belongs_to :user, index: true, foreign_key: false
      t.belongs_to :publisher, index: true, foreign_key: false
      t.belongs_to :publishing_agreement, index: true, foreign_key: false
      t.string :email
      t.timestamps null: false
    end
    
    add_foreign_key "ipi_publishers", "ipis", on_delete: :cascade
    add_foreign_key "ipi_publishers", "publishers", on_delete: :cascade
    
    Publisher.find_each do |publisher|
      
      user = publisher.user
      if ipi = user.ipi
        IpiPublisher.create(
          publisher_id:            publisher.id,
          user_id:                 user.id,
          ipi_id:                  ipi.id,
          email:                   user.email,
          publishing_agreement_id: user.personal_publisher.id
        )
      end
      
    end
    
  end
end
