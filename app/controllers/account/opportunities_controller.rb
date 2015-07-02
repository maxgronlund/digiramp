class Account::OpportunitiesController < ApplicationController
  before_action :set_opportunity, only: [:show, :edit, :update, :destroy, :music_submissions]
  
  include AccountsHelper
  before_action :access_account

  
  def index

    forbidden current_account_user && current_account_user.read_opportunity

    @opportunities = @account.opportunities.order('created_at desc')
    @user = @account.user
    #@authorized = true
    
  end


  def show
    forbidden current_account_user.read_opportunity
    
    @opportunity.create_activity(  :show, 
                              owner: current_user,
                          recipient: @opportunity,
                     recipient_type: @opportunity.class.name,
                         account_id: @opportunity.account_id)
    @user = @account.user
  end

  # GET /opportunities/new
  def new
    forbidden current_account_user.create_opportunity
    @opportunity          = Opportunity.new
    @opportunity.deadline = Date.today + 4.weeks
    @user = current_user
  end

  # GET /opportunities/1/edit
  def edit
    #forbidden unless current_account_user.update_opportunity
    @user = @account.user
  end

  # POST /opportunities
  # POST /opportunities.json
  def create
    
    forbidden current_account_user.create_opportunity
    @opportunity = Opportunity.create(opportunity_params)
    redirect_to account_account_opportunity_path(@account, @opportunity)
    @opportunity.check_default_image
    
    
  end

  # PATCH/PUT /opportunities/1
  # PATCH/PUT /opportunities/1.json
  def update
    #params[:opportunity][:deadline] = Date.strptime("#{params[:opportunity][:deadline]}", "%m/%d/%Y")
    # params[:opportunity][:deadline].gsub('/','-')
    forbidden current_account_user.update_opportunity
    if @opportunity.update(opportunity_params)
      @opportunity.check_default_image
      
      redirect_to account_account_opportunity_path(@account, @opportunity)
    else
      flash[:danger]      = "Unable to update opportunity" 
      redirect_to edit_new_account_account_opportunity_path(@account)
    end
  end
  
  def music_submissions
    forbidden current_account_user.read_opportunity
  end
  
  def invite_provider_by_email
    @opportunity = Opportunity.cached_find(params[:opportunity_id])
    
    redirect_to account_account_opportunity_path(@account, @opportunity)

  end


  def destroy
    forbidden current_account_user.delete_opportunity
    @opportunity_id = @opportunity.id
    @opportunity.destroy
    #redirect_to account_account_opportunities_path(@account)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opportunity
      @opportunity = Opportunity.cached_find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opportunity_params
      #params.require(:opportunity).permit!
      params.require(:opportunity).permit(:title, 
                                          :body, 
                                          :kind, 
                                          :budget,
                                          :deadline,
                                          :account_id,
                                          :territory,
                                          :public_opportunity,
                                          :image,
                                          music_requests_attributes: [:id, 
                                                                      :title, 
                                                                      :body,
                                                                      :duration,
                                                                      :created_at,
                                                                      :scene_number,
                                                                      :link,
                                                                      :up_to_full_use,
                                                                      :opportunity_id,
                                                                      :link_title,
                                                                      :recording_id,
                                                                      :fee,
                                                                      :_destroy])
    end
    

end
