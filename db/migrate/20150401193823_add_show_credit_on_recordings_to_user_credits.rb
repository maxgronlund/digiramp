class AddShowCreditOnRecordingsToUserCredits < ActiveRecord::Migration
  def change
    add_column :user_credits, :show_credit_on_recordings, :boolean, default: true
    
    Ipi.find_each do |ipi|
      if user_credit = UserCredit.where(ipiable_id: ipi.id, ipiable_type: 'Ipi').first
        user_credit.show_credit_on_recordings = ipi.show_credit_on_recordings
        user_credit.save!
      end
    end
  end
end
