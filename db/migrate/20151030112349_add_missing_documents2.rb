class AddMissingDocuments2 < ActiveRecord::Migration
  def change
    User.find_each do |user|
      if publishing_agreements = PublishingAgreement.where(user: user.id, personal_agreement: true)
        if publishing_agreements.count > 1
          publishing_agreements.last.destroy
        end
      end
    end
  end
end
