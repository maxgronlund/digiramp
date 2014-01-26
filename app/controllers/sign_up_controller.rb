class SignUpController < ApplicationController

  def create

    email = params['/sign_up']['email']
    #@user = User.where(email: email).first
    
    go_to = :back
    
    if User.exists?(email: email)
      flash[:error]      = { title: "User exists", body: "You are already signed up for an account. Please login" }
      go_to = login_index_path
      
    else
      @user   = User.create(user_params)
      role = params['/sign_up']['role']
      account = Account.create( title: email, account_type: role, contact_email: email, user_id: @user.id)
      AccountUser.where( account_id: account.id, user_id: @user.id).first_or_create( account_id: account.id, user_id: @user.id, role: role)
      
      @user.name        = email
      
      if@user.save!
        flash[:info]      = { title: "Success", body: "You are signed up as #{params['/sign_up']['role']}" }
        go_to = login_index_path
      else
        account.destroy
        flash[:error]      = { title: "Hmmm", body: "Check email and password" }
      end
    end
    
    redirect_to go_to
  end
  
private

  def user_params
    params.require('/sign_up').permit!
  end
end
