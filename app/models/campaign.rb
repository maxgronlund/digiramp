class Campaign < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  
  has_and_belongs_to_many :client_groups
  

  
  STATUS = ['Draft', 'Delivered']
end
