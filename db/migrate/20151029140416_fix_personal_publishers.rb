class FixPersonalPublishers < ActiveRecord::Migration
  def change
    
    User.find_each do |user|
      if user.personal_publisher_id.nil?
        create_personal_publisher user
      end
      unless publisher = Publisher.find_by( user_id: user.id, id: user.personal_publisher_id)
        
      end
    end
  end
  
  def create_personal_publisher user
    
    publisher = Publisher.where( 
      user_id: user.id,
      personal_publisher: true
    )
    .first_or_create( 
      user_id: user.id,
      personal_publisher: true,
      legal_name: user.get_full_name
    )
    self.update_columns(personal_publisher_id: publisher.id)
    ap publisher
  end
end
