class Wizard::Rights::WorkStartController < Wizard::Rights::CommonWorksController
  
  def new
    @user_id = params[:user_id]
    #@wizard = ::Wizard.new( work_contributor_count: 1, 
    #                        user_id: params[:user_id], 
    #                        wizard_id: @common_work.id, 
    #                        wizard_type: @common_work.class.name
    #                       )
    #redirect_to edit_wizard_rights_common_work_work_start_path( @common_work.id, @wizard.id, user_id: params[:user_id])
  end
  
  def create
    ap params
    
    if Wizard.create(wizard_params)
      redirect_to :back
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @wizard.update(wizard_params)
      redirect_to :back
    else
      render :new
    end
    
    #@wizard.content[:work_contributor_count] = wizard_params[:work_contributor_count]
    #if @wizard.save
    #  redirect_to :back
    #else
    #  render :edit
    #  
    #end
  end
  
  private
  
  def wizard_params
    params.require(:wizard).permit( :work_contributor_count,
                                    :user_id,    
                                    :wizard_id,  
                                    :wizard_type
                                  )
  end
end
