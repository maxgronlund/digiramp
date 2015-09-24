class AddGeneratedFeesToStakes < ActiveRecord::Migration
  def change
    add_column :stakes, :generated_fee, :integer    , default: 0
    add_column :stakes, :generated_income, :integer , default: 0
    
    #Stake.find_each do |stake|
    #  stake.update_income
    #end
  end
end
