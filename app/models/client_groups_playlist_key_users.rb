class ClientGroupsPlaylistKeyUsers < ActiveRecord::Base
  belongs_to :client_group
  belongs_to :playlist_key_user
end
