class PricePlan < ActiveRecord::Base
  #attr_accessible :common_works, :price, :storage, :subscribtion_period, :support, :team_members, :title
  
  def self.lite;      PricePlan.where(title: 'Lite').first_or_create(title: 'Lite', price: '35', storage: '150 mByte', common_works: '20',  subscribtion_period: 'Month',  team_members: '1') end
  def self.pro;       PricePlan.where(title: 'Pro').first_or_create(title: 'Pro', price: '99', storage: '1000 mByte',  common_works: '500', subscribtion_period: 'Month',  team_members: '20' ) end
  def self.standard;  PricePlan.where(title: 'Standard').first_or_create(title: 'Standard', price: '50', storage: '500 mByte',  common_works: '100', subscribtion_period: 'Month',  team_members: '5' ) end

  
end
