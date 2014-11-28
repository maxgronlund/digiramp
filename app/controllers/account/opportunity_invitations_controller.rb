class Account::OpportunityInvitationsController < ApplicationController
  before_action :set_opportunity_invitation, only: [:show, :edit, :update, :destroy]
  include AccountsHelper
  before_filter :access_account

  # GET /opportunity_invitations
  # GET /opportunity_invitations.json
  #def index
  #  @opportunity_invitations = OpportunityInvitation.all
  #end
  #
  ## GET /opportunity_invitations/1
  ## GET /opportunity_invitations/1.json
  #def show
  #end

  # GET /opportunity_invitations/new
  def new
    @user                   = current_user
    @authorized             = true
    @opportunity            = Opportunity.cached_find(params[:opportunity_id])
    @opportunity_invitation = OpportunityInvitation.new
  end

  # GET /opportunity_invitations/1/edit
  def edit
    @opportunity            = Opportunity.cached_find(params[:opportunity_id])
  end



  def create
    
    # validates email here
    
    #/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
    
    
    
    @opportunity            = Opportunity.cached_find(params[:opportunity_id])
    @opportunity_invitation = OpportunityInvitation.create(opportunity_invitation_params)
    
    
    @opportunity_invitation.create_activity(   :created, 
                                   owner: current_user,
                               recipient: @opportunity_invitation,
                          recipient_type: @opportunity_invitation.class.name,
                                account_id: @account.id,
                                  params: { opportunity_id: @opportunity.id
                                          }
                                      ) 


    params[:opportunity_invitation][:invitees].split(/, ?/).each do |email|
      #puts '========================================='
      #puts email
      #puts '========================================='
      user             = User.find_or_invite_from_email( email.downcase.gsub(' ', '') )

      @opportunity_user = OpportunityUser.where( opportunity_id:   @opportunity.id, 
                                                user_id:          user.id,
                                              )
                                              .first_or_create(  
                                                opportunity_id:   @opportunity.id, 
                                                user_id:          user.id,
                                              )
      
      if user.account_activated
        OpportunityMailer.delay.invite(email, @opportunity_invitation.id, user.id, current_user.id)
      else
        user.add_token
        OpportunityMailer.delay.invite_to_account(email, @opportunity_invitation.id, user.id, current_user.id)
      end
      
 
      @opportunity_user.create_activity(   :created, 
                                     owner: current_user,
                                 recipient: @opportunity_user,
                            recipient_type: @opportunity_user.class.name,
                                account_id: @account.id,
                                    params: { opportunity_id: @opportunity.id,
                                      opportunity_user_email: email
                                            }
                                        ) 
                            
                            
    end
    
    
    
    

    
    
    

    redirect_to account_account_opportunity_path(@account, @opportunity)
  end
  


  # PATCH/PUT /opportunity_invitations/1
  # PATCH/PUT /opportunity_invitations/1.json
  def update
    @opportunity            = Opportunity.cached_find(params[:opportunity_id])
    @opportunity_invitation.update(opportunity_invitation_params)
     redirect_to account_account_opportunity_path(@account, @opportunity)
  end

  # DELETE /opportunity_invitations/1
  # DELETE /opportunity_invitations/1.json
  def destroy
    @opportunity            = Opportunity.cached_find(params[:opportunity_id])
    @opportunity_invitation.destroy
     redirect_to account_account_opportunity_path(@account, @opportunity)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opportunity_invitation
      @opportunity_invitation = OpportunityInvitation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opportunity_invitation_params
      params.require(:opportunity_invitation).permit!
    end
end
