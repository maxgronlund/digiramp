class ZappAccountsWithoutUsers3 < ActiveRecord::Migration
  def change
    Account.find_each do |account|
      if account.user.nil?
        begin
          account.destroy
        rescue => e
          ap account.id
          ap e
        end
      end
    end
  end
end
