#require 'uri'

class ClientInvitationMailer < ApplicationMailer

  def send_one_with_avatar client_invitation_id
    client_invitation      = ClientInvitation.cached_find(client_invitation_id)
    email                  = client_invitation.email
    inviter                = client_invitation.user
    avatar_url             = ( URI.parse(root_url) + inviter.image_url(:avatar_92x92) ).to_s
    sender_url             = url_for( controller: '/users', action: 'show', id: inviter.id )
    accept_url             = url_for( controller: '/contact_invitations', action: 'accept_invitation',  contact_invitation_id: client_invitation.uuid )
    decline_url            = url_for( controller: '/contact_invitations', action: 'decline_invitation', contact_invitation_id: client_invitation.uuid )
    receipients_with_names = [{email: email, name: client_invitation.client.name}]
    merge_vars             = [get_merge_vars( email, inviter, accept_url, decline_url, avatar_url, sender_url )]
    
    send_to_mandrill( receipients_with_names, inviter, merge_vars, [client_invitation] )
  end
  
  def get_merge_vars email, inviter, accept_url, decline_url, avatar_url, sender_url
    { rcpt: email,
      vars: [ {name: "USER_NAME",            content: inviter.user_name},
              {name: "PROFESION",            content: inviter.profession},
              {name: "SHORT_DESCRIPTION",    content: inviter.short_description},
              {name: "WRITER",               content: inviter.writer},
              {name: "AUTHOR",               content: inviter.author},
              {name: "PRODUCER",             content: inviter.producer},
              {name: "COMPOSER",             content: inviter.composer},
              {name: "REMIXER",              content: inviter.remixer},
              {name: "MUSICIAN",             content: inviter.musician},
              {name: "DJ",                   content: inviter.dj},
              {name: "ARTIST",               content: inviter.artist},
              {name: "ACCEPT_URL",           content: accept_url},
              {name: "DECLINE_URL",          content: decline_url},
              {name: "AVATAR_URL",           content: avatar_url},
              {name: "SENDER_URL",           content: sender_url}
            ]
    }
  end
  
  # send in batches
  def invite_all_from_group client_group_id
    client_group    = ClientGroup.find(client_group_id)
    client_group.clients.in_groups_of(256) do |client_batch|
      invite_batch( client_group, client_batch)
    end
  end
  
  def invite_batch client_group, client_batch
    
    # collect data
    inviter                 = client_group.user
    avatar_url              = ( URI.parse(root_url) + inviter.image_url(:avatar_92x92) ).to_s
    sender_url              = url_for( controller: '/users', action: 'show', id: inviter.id )
    invitations             = []
    emails                  = []
    accept_urls             = []
    receipients_with_names  = []
    merge_vars              = []
    
    # pack info
    client_batch.each do |client|
      if client && email = client.email
        # Don't invite clients two times
        if client_has_received_email( client )
         
        elsif invitation          = get_client_invitation( client, client_group.id )
          accept_url              = url_for( controller: '/contact_invitations', action: 'accept_invitation', contact_invitation_id:  invitation.uuid )
          decline_url             = url_for( controller: '/contact_invitations', action: 'decline_invitation', contact_invitation_id: invitation.uuid )
          receipients_with_names << {email: invitation.email, name: client.name}
          invitations            << invitation
          merge_vars             << get_merge_vars( email, inviter, accept_url, decline_url, avatar_url, sender_url )           
        end
      end
    end
     
    # send batch
    unless merge_vars.empty?
      send_to_mandrill( receipients_with_names, inviter, merge_vars, invitations )
    else
      Opbeat.capture_message("ClientInvitationMailer: client_group_id: #{client_group.id}")
    end
  end
  
  def send_to_mandrill receipients_with_names, inviter, merge_vars, invitations
    begin
      template_name = "user-invitation"
      template_content = []
      message = { to: receipients_with_names ,
                  from: {email: "noreply@digiramp.com"},
                  subject: "(DigiRAMP signup error fixed) Please join my network on DigiRAMP",
                  tags: ["user-invitation"],
                  track_clicks: true,
                  track_opens: true,
                  subaccount: inviter.mandrill_account_id,
                  #recipient_metadata: recipient_metadata,
                  merge_vars: merge_vars
                }
      resoults =  mandril_client.messages.send_template template_name, template_content, message
      # stamp ids
      resoults.each_with_index do |resoult, index|
        begin
          invitations[index].mandrill_id = resoult["_id"]
          invitations[index].sent!
          invitations[index].save
        rescue
        end
      end

    rescue Mandrill::Error => e
      
      message = "#{e.class} - #{e.message}"
      ErrorNotification.post message
    end
  end
  
  def client_has_received_email client
    
    client_invitation = ClientInvitation.where( user_id: client.user_id, email: client.email ).first
    client_invitation && !client_invitation.pending?
  end

  def get_client_invitation client, client_group_id
    ClientInvitation.where( user_id:          client.user_id, email: client.email )
          .first_or_create( user_id:          client.user_id,
                            email:            client.email, 
                            client_id:        client.id,
                            account_id:       client.account_id, 
                            client_group_id:  client_group_id,
                            uuid:             UUIDTools::UUID.timestamp_create().to_s)        
  end
end