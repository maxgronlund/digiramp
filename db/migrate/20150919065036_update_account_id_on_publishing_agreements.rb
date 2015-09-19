class UpdateAccountIdOnPublishingAgreements < ActiveRecord::Migration
  def change
    
    
    
    User.find_each do |user|
      user.publishers.each do |publisher|
        publisher.publishing_agreements.each do |publishing_agreement|
          publishing_agreement.update(account_id: user.account.id, user_id: user.id)
        end
      end
    end
  end
end
