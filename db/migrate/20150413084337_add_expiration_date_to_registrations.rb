class AddExpirationDateToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :expiration_date, :date
    
    Registration.update_all(expiration_date: Date.today + 1.months)
  end
end
