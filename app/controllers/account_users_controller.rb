class AccountUsersController < ApplicationController

  before_filter :there_is_access_to_the_account
  #respond_to :html, :xml, :json

  def index
    @blog = Blog.account_users
    @title_and_body  = BlogPost.where(identifier: 'Page Title and Body', blog_id: @blog.id)
                                         .first_or_create(identifier: 'Page Title and Body', blog_id: @blog.id, title: 'Users', body: 'Users with access to the account')
    
  end
  
  def show
    
  end
  
  def new
    @account_user = @account.account_users.new
    @roles = AccountUser::ROLES
    @roles.delete("Account Owner")

  end

  def create
    
    if @user = User.where(email: params[:account_user][:email]).first
      account_user = AccountUser.create!(account_id: @account.id, user_id: @user.id, role: params[:account_user][:role], invitation_message: params[:account_user][:invitation_message])
      flash[:info] = { title: "User invited", body: "successfully invited user with email: #{ params[:account_user][:email]}" }
      redirect_to account_account_users_path @account
    else
      flash[:danger] = { title: "User is not a member", body: "Please ask the person you are about to invite to sign up for an account" }
      redirect_to account_account_users_path @account
     # @user = User.create( email: params[:account_user][:email], name: params[:account_user][:email], current_account_id: @account.id, password: 'qLp8GtNwlx7WVBY3Xj9QTDi5PR', password_confirmation: 'qLp8GtNwlx7WVBY3Xj9QTDi5PR')
     # account_user = AccountUser.create(account_id: @account.id, user_id: @user.id, role: params[:account_user][:role], invitation_message: params[:account_user][:invitation_message])
     # @user.signed_up_and_invited_to @account.id, params[:account_user][:invitation_message]
    end
    #
    #if params[:account_user][:permitted_models_attributes]
    #  params[:account_user][:permitted_models_attributes].each do |pma|
    #    attributes = pma[1]
    #    attributes.delete("id")
    #  
    #    permitted_model   = PermittedModel.where(permitted_model_type_id: attributes[:permitted_model_type_id], account_user_id: account_user.id).first
    #    permitted_model.c = attributes[:c]
    #    permitted_model.r = attributes[:r]
    #    permitted_model.u = attributes[:u]
    #    permitted_model.d = attributes[:d]
    #    permitted_model.save!
    #  end
    #end
    #
    #flash[:info] = { title: "User invited", body: "successfully invited user with email: #{ params[:account_user][:email]}" }
    #redirect_to session[:last_prefering_page]
  end

  def edit
    logger.debug '----------------------------------------------------------------'
    logger.debug @account.title
    logger.debug params
    logger.debug '----------------------------------------------------------------'
    @account_user = AccountUser.find(params[:id])
    @roles = AccountUser::ROLES
    @roles.delete("Account Owner")
    
    @blog = Blog.account_users
    @administrator  = BlogPost.where(identifier: 'Administrator', blog_id: @blog.id)
                                         .first_or_create(identifier: 'Administrator', blog_id: @blog.id, title: 'Administrator', body: 'Administrators has global access to all content')
    @client  = BlogPost.where(identifier: 'Client', blog_id: @blog.id)
                                         .first_or_create(identifier: 'Client', blog_id: @blog.id, title: 'Client', body: 'You will grand client permission on a pr asset basis')
    
  end
  
  def update
    logger.debug '----------------------------------------------------------------'
    logger.debug 'update'
    logger.debug @account.title
    logger.debug '----------------------------------------------------------------'
    @account_user = AccountUser.find(params[:id])
    @account_user.update(account_user_params)
    
    #if params[:account_user][:permitted_models_attributes]
    #  params[:account_user][:permitted_models_attributes].each do |pma|
    #    attributes = pma[1]
    #    permitted_model = PermittedModel.find(attributes[:id])
    #    attributes.delete("id")
    #    
    #    permitted_model.update(attributes)
    #  end
    #end
    #
    redirect_to_return_url account_account_users_path(@account)
    
  end
  
  def destroy
    account_user = AccountUser.find(params[:id])
    account_user.destroy
    
    flash[:info] = { title: "User removed", body: "the user has no more access to this account" }
    redirect_to_return_url account_path(@account)
    #redirect_to :back
  end
private

  #def invite( account, user, role )
  #  @account_user = AccountUser.where(account_id: account.id, user_id: user.id).first_or_create
  #  @account_user.update(account_id: params[:account_id], user_id: user.id, role: role)
  #  (params[:account_user][:permitted_models_attributes]||{}).each do |k,v|
  #    @account_user.permitted_models.where(permitted_model_type_id: v[:permitted_model_type_id]).first.update(v)
  #  end
  #  
  #end
  #
  def account_user_params
    #if current_user.can_administrate( @account)
      params.require(:account_user).permit!
      #end
  end
  #
  #def check_permitted_models
  #  PermittedModelType.all.each do |permitted_model_type|
  #    @account_user.permitted_models.where(  account_user_id: @account_user.id, permitted_model_type_id: permitted_model_type.id) .first_or_create(   account_user_id: @account_user.id,permitted_model_type_id: permitted_model_type.id)
  #  end
  #end
  
end
