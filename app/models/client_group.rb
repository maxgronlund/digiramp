class ClientGroup < ActiveRecord::Base
  belongs_to :account
  has_and_belongs_to_many :clients
  
  # a client group can be used for many playlist
  has_and_belongs_to_many :playlist_key_users
  
end
