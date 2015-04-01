class AddConfirmationToUserCredits < ActiveRecord::Migration
  def change
    add_column :user_credits, :confirmation, :string
    
    UserCredit.find_each do |user_credit|
      user_credit.confirmation = user_credit.ipiable.confirmation
      user_credit.save!
    end
  end
end
