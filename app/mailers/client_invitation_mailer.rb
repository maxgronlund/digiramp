require 'json'
require 'uri'

class ClientInvitationMailer < ActionMailer::Base
  default from: "noreply@digiramp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.client_invitation_mailer.send_with_avatar.subject
  #
  
  
  def import_form_linkedin client_import_id
    
    #client_import = ClientImport.cached_find(client_import_id)
    
    #clients = []
    
    #client_import.clients.each do |client|
    #  #ap client
    #end

  end
  
  # notice max 1000 at a time
  def invite_all_from_group client_group_id
    ap 'invite_all_from_group'
    client_group    = ClientGroup.find(client_group_id)
    @inviter        = client_group.user
    user_name       = @inviter.user_name
    @avatar_url     = ( URI.parse(root_url) + @inviter.image_url(:avatar_92x92) ).to_s
    
    client_group.clients.in_groups_of(50) do |clients| # in chuncks
      # create array of invitations
      sleep 5
      invitations   = []
      index         = 0
      
      clients.each do |client|
       
        if client
          unless client.member_id.nil?
            invitations[index] = create_invitation( client )
            index += 1
          end
        end
      end
      
      
      # prepare custom fields
      emails        = []
      accept_urls   = []
      decline_urls  = []
      user_names    = []
      index         = 0
      
      invitations.each do |invitation|
        if email = EmailValidator.saintize( invitation.client.email )
          emails[index]         = email
          accept_urls[index]    = url_for( controller: '/contact_invitations', action: 'accept_invitation', contact_invitation_id: invitation.uuid )
          decline_urls[index]   = url_for( controller: '/contact_invitations', action: 'decline_invitation', contact_invitation_id: invitation.uuid )
          user_names[index]     = user_name    
          index += 1
        else
          invitation.destroy!
        end
      end
      
      # prepre JSON
      x_smtpapi = { 
                    to: emails,
                    filters: { templates: {
                                         settings: {
                                                       enabled: 1,
                                                       template_id: "9117870a-825a-4c81-8c04-8ff68d422ff7"
                                                     }
                                        }
                             }, 
                     sub: {  
                             "<%user_name%>".to_sym =>    user_names,
                             "--accept_url--".to_sym =>   accept_urls,
                             "--decline_url--".to_sym =>  decline_urls,
                             "--avatar_url--".to_sym =>   decline_urls
                          } 
      
                  }
      
      unless emails.empty?
        #headers['X-SMTPAPI'] = JSON.generate(x_smtpapi)
        
        headder = JSON.generate(x_smtpapi)
        IssueEvent.create(title: 'ClientInvitationMailer#invite_all_from_group', data: headder, subject_type: 'ClientGroup', subject_id: client_group_id)
        headers['X-SMTPAPI'] = headder
        
        mail to: "info@digiramp.com", subject: "I'd like to add you my DigiRAMP music network"
      end
    end
    
    
  end
  
  def create_invitation client
    
    ClientInvitation.create( account_id: client.account_id, 
                             client_id:  client.id,
                             user_id:    client.user_id,
                             status:     'Invited',
                             uuid:       UUIDTools::UUID.timestamp_create().to_s )
    
  end
  

  
  def send_one_with_avatar client_invitation_id
    @client_invitation    = ClientInvitation.cached_find(client_invitation_id)
    
    @client               = @client_invitation.client
    @inviter              = @client_invitation.user
    @accept_url           = url_for( controller: '/contact_invitations', action: 'accept_invitation', contact_invitation_id: @client_invitation.uuid )
    @decline_url          = url_for( controller: '/contact_invitations', action: 'decline_invitation', contact_invitation_id: @client_invitation.uuid )
    @avatar_url           = ( URI.parse(root_url) + @inviter.image_url(:avatar_92x92) ).to_s
    
                
    x_smtpapi = { 
                  to: [@client.email],
                  filters: { templates: {
                                       settings: {
                                                     enabled: 1,
                                                     template_id: "9117870a-825a-4c81-8c04-8ff68d422ff7"
                                                   }
                                      }
                           }, 
                   sub: {  
                           "<%user_name%>".to_sym =>    [ @inviter.user_name.to_s ],
                           "--accept_url--".to_sym =>   [ @accept_url],
                           "--decline_url--".to_sym =>  [ @decline_url]
                        } 
    
                }
    

    
    headers['X-SMTPAPI'] = JSON.generate(x_smtpapi)
    
    #headers['X-SMTPAPI'] = '{ "to": ["max@haxecasts.com"], 
    #                          "filters": {"templates": {"settings": {"enabled": 1,"template_id": "9117870a-825a-4c81-8c04-8ff68d422ff7"}}}, 
    #                          "sub": {  "<%user_name%>":  ["' + @inviter.user_name.to_s + '"],
    #                                    "--accept_url--": ["' + @accept_url + '"],
    #                                    "--decline_url--": ["' + @decline_url + '"]
    #                                  } 
    #                        }'
    #
    #
    #                        
    #
    #                  }'

    mail to: "info@digiramp.com", subject: "I'd like to add you to my network of music professionals"
    
    #headers['X-SMTPAPI'] = '{ "to": ["max@digiramp.com", "max@pixelsonrails.com"]}'
    #
    #mail to: 'max@digiramp.com'
    
    

    
  end

end
