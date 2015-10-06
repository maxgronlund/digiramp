class AddPersonalPublisherIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :personal_publisher_id, :integer
    add_column :users, :personal_publishing_status,         :string    , default: ''
    add_column :users, :exclusive_publishers_email,         :string    , default: ''
    add_column :users, :publishing_administrators_email,    :string    , default: ''
    add_column :publishers, :publishing_administrator_email,          :string    , default: ''
    add_column :publishers, :publishing_administrator_user_id,        :string    , default: ''
    add_column :publishers, :publishing_administrator_split,          :integer    , default: 0
    
    User.find_each do |user|
      user.update(
        personal_publisher_id: Publisher.find_by(user_id: user.id, personal_publisher: true),
        personal_publishing_status:    'I own and control my own publishing'
      )
    end
    
    Publisher.find_each do |publisher|
      publisher.update(
        publishing_administrator_user_id: publisher.user_id
      )
    end
  end
end
