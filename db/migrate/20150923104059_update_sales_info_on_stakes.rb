class UpdateSalesInfoOnStakes < ActiveRecord::Migration
  def change
    change_column :shop_stripe_transfers, :application_fee, :integer, default: 0
    change_column :shop_stripe_transfers, :amount, :integer, default: 0
    
    Stake.find_each do |stake|
      income = 0
      fees   = 0
      units_sold = 0
      #psql exesizee
      stake.stripe_transfers.each do |stripe_transfer|
        income     += stripe_transfer.amount.to_i
        fees       += stripe_transfer.payment_fee.to_i + stripe_transfer.application_fee.to_i
        units_sold += 1
      end
    
      stake.update(
        generated_income: income,
        generated_fee: fees,
        units_sold:  units_sold
      )
      ap stake
    end
  end
end
