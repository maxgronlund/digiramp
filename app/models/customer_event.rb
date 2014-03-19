class CustomerEvent < ActiveRecord::Base
  belongs_to :account
  belongs_to :account_user
  
  EVENT_TYPES = { private_playlist: "Private Playlist", 
                  invite_to_common_work: "Invite to Common Work", 
                  invite_to_recording: "Invite To Recording",
                  invite_to_account:  "Invite to Account", 
                  phone_call: "Phone Call", 
                  email: "Email"}
end


