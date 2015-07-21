class UpdateContactEmailOnAccounts < ActiveRecord::Migration
  def change
    Account.find_each do |account|
      if account.contact_email.blank?
        account.contact_email = account.user.email
      end
      
      unless EmailSanitizer.validate account.contact_email
        if EmailSanitizer.validate account.user.email
          account.contact_email = account.user.email
        end
      end

      if account.title.blank?
        account.title = account.user.user_name
      end

      if account.title.blank?
        account.title = account.user.user_name
      end

      if account.stripe_flat_transfer_fee.to_i == 0
        account.stripe_flat_transfer_fee = 10
      end

      if account.stripe_percent_transfer_fee.to_f == 0.0
        account.stripe_percent_transfer_fee = 0.01
      end
      
      begin
        account.save!
      rescue
        ap "unable to save account id: #{account.id}"
        ap "account contact mail: #{account.contact_email}"
        ap "user slug: #{account.user.slug}"
      end
    end
  end
end


# unless EmailSanitizer.validate( 'account.contact_email') ap 'invalid' end