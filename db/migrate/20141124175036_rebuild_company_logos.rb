class RebuildCompanyLogos < ActiveRecord::Migration
  def change
    Account.find_each do |account|
      begin
        account.logo.recreate_versions! if account.logo
      rescue
        #puts account.title
      end

      
    end
  end
end
 