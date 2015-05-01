class Admin::FrontEndContentsController < ApplicationController
  
  before_action :admins_only



  def edit
    @front_end_content = FrontEndContent.get_content
  end

  def update
    @front_end_content = FrontEndContent.get_content
    if @front_end_content.update(front_end_content_params)
      redirect_to edit_admin_front_end_content_path(@front_end_content)
    else
      render :edit  
    end
  end

 

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def front_end_content_params
      params.require(:front_end_content).permit!
    end
end
