class SetPersonalPublishersShare < ActiveRecord::Migration
  def change
    User.find_each do |user|
      user.personal_publishing_agreement.update(split: 0.0)
    end
  end
end
