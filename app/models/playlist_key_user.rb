# notice the plylist user is not limited to one user 
# but also supports client groups

class PlaylistKeyUser < ActiveRecord::Base
  
  belongs_to :account
  belongs_to :client

  
  
  has_and_belongs_to_many :client_groups
  
end
