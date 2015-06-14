require 'json'
require 'uri'


class ClientInvitationMailer < ActionMailer::Base
  
  def mandril_client
    @mandrill_client ||= Mandrill::API.new Rails.application.secrets.email_provider_password
  end
  
  def send_one_with_avatar client_invitation_id
    client_invitation = ClientInvitation.cached_find(client_invitation_id)
    inviter       = client_group.user
    avatar_url    = ( URI.parse(root_url) + inviter.image_url(:avatar_92x92) ).to_s
    sender_url    = url_for( controller: '/users', action: 'show', id: inviter.id )
    accept_url    = url_for( controller: '/contact_invitations', action: 'accept_invitation', contact_invitation_id:  client_invitation.uuid )
    
  end
  
  # send in batches
  def invite_all_from_group client_group_id
    ap '+++++++++++++++++++++++++++++++ invite_all_from_group 8 +++++++++++++++++++++++++++++++++++++++++++'
    client_group    = ClientGroup.find(client_group_id)
    client_group.clients.in_groups_of(128) do |client_batch|
      invite_batch( client_group, client_batch)
    end
    ap '+++++++++++++++++++++++++++++++++++++++ done ++++++++++++++++++++++++++++++++++++++++++++++++++++++'
  end
  
 
    
  def invite_batch client_group, client_batch
    
    ## collect data
    inviter       = client_group.user
    avatar_url    = ( URI.parse(root_url) + inviter.image_url(:avatar_92x92) ).to_s
    sender_url    = url_for( controller: '/users', action: 'show', id: inviter.id )

    invitations   = []
    emails        = []
    accept_urls   = []
    receipients_with_names   = []
    #recipient_metadata       = []
    merge_vars               = []
    
    # pack info
    client_batch.each do |client|
      if client && email = client.email
        # Don't invite clients two times
        if client_has_received_email( client )
          ap "client: #{client.email} has received email"
        elsif invitation        = get_client_invitation( client, client_group.id )
          accept_url = url_for( controller: '/contact_invitations', action: 'accept_invitation', contact_invitation_id:  invitation.uuid )
          
          receipients_with_names << {email: invitation.email, name: client.name}
          #recipient_metadata     << {rcpt:  invitation.email, values: {invitation_id: invitation.id}}

          invitations << invitation

          merge_vars << {
                         rcpt: invitation.email,
                         vars: [
                                 #{name: "TITLE",       content: message.title},
                                 #{name: "BODY",        content: message.body},
                                 {name: "USER_NAME",            content: inviter.user_name},
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
                                 {name: "AVATAR_URL",           content: avatar_url},
                                 {name: "SENDER_URL",           content: sender_url}
                                 #{name: "MESAGE_ID",            content: message.id.to_s}
                                 ]
                        }
          
          
        end
      end
    end
    
    
    
    # send batch
    unless merge_vars.empty?
      begin
        template_name = "user-invitation"
        template_content = []
        message = {
          to: receipients_with_names ,
          from: {email: "noreply@digiramp.com"},
          subject: "Please join my network at DigiRAMP",
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
          invitations[index].mandrill_id = resoult["_id"]
          invitations[index].sent!
          invitations[index].save
        end
          
          
      rescue Mandrill::Error => e
        Opbeat.capture_message("#{e.class} - #{e.message}")
      end
    else
      ap "ClientInvitationMailer: client_group_id: #{client_group.id}"
      Opbeat.capture_message("ClientInvitationMailer: client_group_id: #{client_group.id}")
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
  

  
  
  #ClientInvitationMailer.send_one_with_avatar
    
  private
  
  def template_id
    "9117870a-825a-4c81-8c04-8ff68d422ff7"
  end
  

end
