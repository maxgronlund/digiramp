class SetIpiPublishingStatus < ActiveRecord::Migration
  def change
    add_column :users, :status, :integer
    User.find_each do |user|
      begin
        case user.personal_publishing_status
          
        when "I own and control my own publishing"
          user.is_self_published!
        when "I have an exclusive publisher"
          user.has_an_exclusive_publisher!
        when "I have many publishers"
          user.has_many_publishers
        else
          user.has_to_set_publishing!
        end
      rescue => e
        ap e
      end
    end
  end
end
