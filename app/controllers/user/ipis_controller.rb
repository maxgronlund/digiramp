class User::IpisController < ApplicationController
  
  before_action :access_user
  
  def index
    @common_work_ipis = @user.common_work_ipis
  end
  
  def show
    @ipi                              = Ipi.cached_find(params[:id])
    #@ipi_publishing_agreement         = IpiPublishingAgreement.new
    #not_found( params )  unless ( @common_work = @ipi.common_work ) && ( account = @common_work.account ) && ( @requester = account.user )

  end
  
  def new
    @ipi          = Ipi.new
    @common_work  = CommonWork.cached_find(params[:common_work_id])
    
    #@ipi.title    = "Please confirm your rights on #{@common_work.title}"
    #@ipi.message  = "Hi \nI would like you to confirm you share and rights on #{@common_work.title} as:\n#{@ipi.roles_as_string} \n\n--#{@user.user_name}"
    #render nothing: true
  end
  
  def create
   
    @common_work = CommonWork.cached_find(params[:common_work_id])
    params[:ipi][:uuid]   = UUIDTools::UUID.timestamp_create().to_s
    params[:ipi][:email]  = EmailSanitizer.saintize( params[:ipi][:email] )
    params[:ipi][:status] = 0
    @ipi = Ipi.new(ipi_params)
    
    respond_to do |format|
      if @ipi.save
        
        # make sure all ips get a fair share
        @common_work.update_publishers_payment
        
        format.html { 
          if @ipi.is_published? && @ipi.user && (@ipi.user_id == @user.id)
            redirect_to new_user_user_common_work_ipi_ipi_publisher_path(@user,  @common_work, @ipi)
          else
            redirect_to user_user_common_work_path(@user, @common_work) 
          end
          #if params[:commit] == "Save and add next"
          #  redirect_to new_user_user_common_work_ipi_path(@user, @common_work) 
          #  
          #else
          #  redirect_to user_user_common_work_path(@user, @common_work) 
          #end
        }
        format.json { render :show, status: :created, location: @ipi }
      else
        format.html { render :new }
        format.json { render json: @ipi.errors, status: :unprocessable_entity }
      end
    end
  end
    
  
  
  def edit
     @ipi                   = Ipi.cached_find(params[:id])
     @common_work           = CommonWork.cached_find(@ipi.common_work_id)
     @publishing_agreements = PublishingAgreement.where(email: @ipi.email)
  end
  
  def update
    @ipi          = Ipi.cached_find(params[:id])
    @common_work  = CommonWork.cached_find(@ipi.common_work_id)
    
    if @ipi.update(ipi_params)
      @ipi.attach_to_user
      
      if @ipi.user_id == @user.id
        #ap 'hey confirm this'
        @ipi.update(confirmation: 'Confirmed')
        @ipi.accepted!
      end

      # make sure all ips get a fair share
      @common_work.update_publishers_payment
      
      
      #if params[:commit] == 'Save and send message'
      #  @ipi.send_confirmation_request 
      #  redirect_to user_user_common_work_path(@user, @common_work)
      #  #redirect_to new_user_user_common_work_ipi_path(@user, @common_work)
      ##elsif params[:commit] == "Update"
      ##  #redirect_to session[:go_to_after_update_ipi]
      #elsif params[:commit] == "Save"
      #  redirect_to user_user_common_work_path(@user, @common_work)
      #  #redirect_to new_user_user_common_work_ipi_path(@user, @common_work)
      #elsif params[:commit] == "Send"
      #  @ipi.send_confirmation_request 
      #end
      
       
    else
      render :edit
    end
  end
  
  def destroy
    @ipi         = Ipi.cached_find(params[:id])
    @ipi.destroy
    @common_work = CommonWork.cached_find(@ipi.common_work_id)
    redirect_to user_user_common_work_path(@user, @common_work)
  end

 
private

  def ipi_params
    params.require(:ipi).permit(
      :id,
      :full_name,
      :address,
      :email,
      :created_at,
      :updated_at,
      :user_id,
      :ipi_code,
      :cae_code,
      :uuid,
      :pro_affiliation_id,
      :ok,
      address_attributes: [  
        :first_name,
        :middle_name,
        :last_name,
        :address_line_1,
        :address_line_2,
        :city,
        :state,
        :country,
        :id,
        :zip_code
      ]
    )
  end
  
  
end