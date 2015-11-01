class CreateUserPublishers < ActiveRecord::Migration
  def change
    create_table :user_publishers do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :publisher, index: true, foreign_key: true
      t.string :email

      t.timestamps null: false
    end
    
    User.find_each do |user|
      
      user.publishing_agreements.each do |publishing_agreement|
        if publisher = publishing_agreement.publisher
          UserPublisher.where(
            user_id:      user.id,
            publisher_id: publisher.id
          )
          .first_or_create(
            user_id:      user.id,
            publisher_id: publisher.id,
            email:        publisher.email
          )
        end
        
      end
    end
  end
end
