class AddRegistrationDateToCommonWorks < ActiveRecord::Migration
  def change
    add_column :common_works, :registration_date, :string, default: ''
    add_column :common_works, :bmi_work_id, :string, default: ''
    
    
  end
end
