class User::UsersController < ApplicationController
  
  
  def show
    begin @user = User.cached_find(params[:id])
      redirect_to user_path( @user )
    rescue
      not_found
    end
  end
  
  def update
    @user = User.cached_find(params[:id])
    @user.update(user_params)
    @user.update_meta
    
    @user.ipi.update(ipi_code: @user.ipi_code)
    
    if @user.personal_publisher.address.empty?
      @user.copy_address_to( @user.personal_publisher.address )
    end
    
    if !@user.ipi_code.nil? && @user.personal_publisher.ipi_code.nil?
      @user.personal_publisher.update(ipi_code: @user.ipi_code)
    end
    
    #update_ips
    redirect_to user_user_legal_index_path( @user)
  end
  
  def user_params
    params.require(:user).permit!#( UserParams::PUBLIC_PARAMS ) 
  end
  
  private
  
  #def update_ips
  #  @user.ipis.update_all(full_name: @user.full_name)
  #end
  
end
