class InvitesController < ApplicationController

	def index
    return forbidden unless current_user
    provider =  params[:provider]
    logger.info '==========================================='
    logger.info provider
    logger.info '==========================================='
    contacts = request.env['omnicontacts.contacts']
    

    @client_import = ClientImport.create(
      user_id:      current_user.id,
      account_id:   current_user.account_id,
      user_uuid:    current_user.uuid,
      source:       'Google mail'
    )
    @client_group = ClientGroup.create(
      title:            "Invitation from #{provider} #{@client_import.id}",
      account_id:       current_user.account_id,
      description:      "Invitation from #{provider} #{@client_import.id}",
      user_uuid:        current_user.uuid,
      user_id:          current_user.id,
      invited:          false,
      invitation_count: 0,
      sents:            0,
      opens:            0
    )
    contacts.each do |c|
      logger.info c
      logger.info '--------------------------'
      address_work  = nil
      city_work     = nil
      email_address = nil
      if emails = c[:emails]
        if email = emails.first
          email_address = email[:email]
          if addresses = c[:addresses]
            addresses.each do |address|
              if address[:name] == 'work'
                address_work = address[:address_1]
                city_work    = address[:city]
              end # end if work
            end # addresses.each
          end # end if addresses

          client = Client.where(
            email:     email_address
          )
          .first_or_create(
            account_id:                 current_user.account_id,
            user_uuid:                  current_user.uuid,
            name:                       c[:name],
            last_name:                  c[:last_name],
            #title:
            #photo:
            #telephone_home:
            #business_phone:
            #business_fax:
            #fax_home:
            #cell_phone:
            #company:
            #capacity:
            #address_home:
            address_work:            address_work,
            city_work:               city_work,
            #state_work:
            #zip_work:
            #country_work:
            email:                   email_address,
            #home_page:
            #department:
            #revision:
            #created_at:
            #updated_at:
            #assistant:
            #direct_phone:
            #direct_fax:
            #business_email:
            #show_alert:
            user_id:               current_user.id,
            #full_name:
            #member_id:
            client_import_id:      @client_import.id

          )
          
          
          
          
          unless client_invitation = ClientInvitation.find_by( 
              account_id: current_user.account_id, 
              email: client.email
            )
            #client_invitation = ClientInvitation.create(
            #  account_id:   current_user.account_id, 
            #    client_id:  client.id,
            #    user_id:    current_user.id,
            #    uuid:       UUIDTools::UUID.timestamp_create().to_s,
            #    email:      client.email 
            #)
            
            client_group_client = ClientGroupsClients.create(
              client_group_id: @client_group.id,
              client_id:       client.id,
              user_uuid:       current_user.uuid
            )
            
            #client_invitation.send_one_with_avatar
            #invitations_send_to[invitations_send_to_index] = email 
            #invitations_send                      += 1
          end
          
         
        end # end if email
      end # end if emails
    end # end of contacts.each
    @client_group.invite_clients

    redirect_to user_user_gmail_invitation_path(current_user, @client_import)
  end

  def failure
    
  end

end