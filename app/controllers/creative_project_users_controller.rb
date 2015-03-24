class CreativeProjectUsersController < ApplicationController
  #before_action :set_creative_project_user, only: [:new, :create]


  def new
    ap params

    
    @creative_project         = CreativeProject.cached_find(params[:creative_project_id])
    @user                     = @creative_project.user
    @creative_project_role    = CreativeProjectRole.cached_find(params[:creative_project_role_id])
    ap @creative_project_role
    role_to_messages = {writer:                         " as a writer.",
                        composer:                       " as a composer.",
                        musician:                       " as a musician.",
                        vocal:                          " with my vocal.",
                        dancer:                         " as a dancer.",
                        'live performer'.to_sym =>      " as a live performer.",
                        producer:                       " as a producer.",
                        'studio facility'.to_sym =>     " with a studio facility.",
                        'financial service'.to_sym =>   " with financial services.",
                        'legal service'.to_sym =>       " with legal services.",
                        publisher:                      " as a publisher.",
                        remixer:                        " as a remixer.",
                        'audio engineer'.to_sym =>      " as a audio engineer.",
                        'video artist'.to_sym =>        " as a video artist.",
                        'graphic artist'.to_sym =>      " as a graphic artist.",
                        other:                          " with other skils."} 
    
    
    message = "Hi #{@user.user_name}. \nI woul like to join the project: #{@creative_project.title}"
    begin
      message += role_to_messages[@creative_project_role.role.to_sym]
    rescue
    end
    message += "\n\n-- #{current_user.user_name}"
    
    role_to_messages[@creative_project_role.role.to_sym]
    @creative_project_user    = CreativeProjectUser.new(message: message, creative_project_role_id: @creative_project_role.id)
  end

  def edit
  
  end


  def create
    #@user                     = User.cached_find(params[:user_id])
    @creative_project         = CreativeProject.cached_find(params[:creative_project_id])
    
    unless CreativeProjectUser.where( creative_project: @creative_project.id, user_id: current_user.id, creative_project_role_id: params[:creative_project_role_id]).first
      @creative_project_user = CreativeProjectUser.new(creative_project_user_params)
      @creative_project_user.save!
    end
    redirect_to creative_project_path( @creative_project)
    
    #@creative_project_user = CreativeProjectUser.new(creative_project_user_params)
    #
    #if @creative_project_user.save!
    #  redirect_to user_user_creative_project_path(@user, @creative_project)
    #end
      

    #respond_to do |format|
    #  if @creative_project_user.save
    #    format.html { redirect_to @creative_project_user, notice: 'Creative project user was successfully created.' }
    #    format.json { render :show, status: :created, location: @creative_project_user }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @creative_project_user.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  #def update
  #
  #  
  #  @creative_project_user.approved_by_project_manager = params[:approved_by_project_manager]
  #  @creative_project_user.dismissed_by_project_manager = params[:dismissed_by_project_manager]
  #  @creative_project_user.save!
  #  
  #  @creative_project_role    = CreativeProjectRole.cached_find(params[:creative_project_role_id])
  #  @creative_project         = CreativeProject.cached_find(params[:creative_project_id])
  #  
  #  redirect_to user_user_creative_project_creative_project_role_path(@user, @creative_project, @creative_project_role)
  #  
  #end
  #
  #def destroy
  #  @creative_project_user.destroy
  #  respond_to do |format|
  #    format.html { redirect_to creative_project_users_url, notice: 'Creative project user was successfully destroyed.' }
  #    format.json { head :no_content }
  #  end
  #end

  private

    #def set_creative_project_user
    #  @creative_project_user = CreativeProjectUser.find(params[:id])
    #end


    def creative_project_user_params
      params.require(:creative_project_user).permit!
    end
end
