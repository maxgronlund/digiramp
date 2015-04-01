class SanitizeEmails < ActiveRecord::Migration
  def change
    
    User.find_each do |user|
      
      user.email = EmailSanitizer.saintize user.email
      begin
        user.save!
      rescue
        if user.account
          user.account.destroy!
        else
           user.destroy!
        end
      end
    end
  end
end
