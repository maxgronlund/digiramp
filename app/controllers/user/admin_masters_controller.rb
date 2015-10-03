class User::AdminMastersController < ApplicationController
  before_action :access_user
  def index

    #if params[:commit] == 'Go'
    #  @remove_old_recordings = true
    #  session[:query] = params[:query]
    #end
    
    #session[:query] = nil if params[:clear] == 'clear'
    #params[:query]  = session[:query]

    
    @recordings =  Recording.recordings_search(@user.recordings, params[:query])
                            .order('uniq_position desc')
                            .page(params[:page]).per(32)

  end

  def show
  end

  def edit
  end
  
  def destroy
    @recording_id = params[:id]
    @recording    = Recording.find(@recording_id)

    common_work = @recording.get_common_work
    
    
    #@recording.destroy
    @recording.user_id    = User.system_user.id
    @recording.account_id = User.system_user.account.id
    @recording.privacy    = 'Only me'
    @recording.remove_from_collections
    @recording.save(validate: false)
    common_work.update_completeness if common_work
    

    redirect_to user_user_admin_masters_path(@user)

  end

end
