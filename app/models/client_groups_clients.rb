class ClientGroupsClients < ActiveRecord::Base
  belongs_to :client_group
  belongs_to :client
  
end
