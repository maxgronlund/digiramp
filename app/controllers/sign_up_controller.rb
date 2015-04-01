class SignUpController < ApplicationController

  def create

    email = params['/sign_up']['email']
    
    sanitized_email = EmailSanitizer.saintize email
    params['/sign_up']['email']  =  sanitized_email
    go_to = :back
    
    if User.exists?(email: sanitized_email)
      flash[:error]      = { title: "User exists", body: "You are already signed up for an account. Please login" }
      go_to = login_index_path
      
    else

      @user   = User.create(user_params)
      
      role = params['/sign_up']['role']
      account = Account.create( title: user_params[:user_name], 
                                account_type: role, 
                                contact_email: email, 
                                user_id: @user.id,
                                expiration_date: Date.current + 6.months)
      
      AccountUser.where( account_id: account.id, user_id: @user.id).first_or_create(  account_id: account.id, 
                                                                                      user_id: @user.id, 
                                                                                      role: AccountUser::ROLES[0],
                                                                                       expiration_date: Date.current()>>1)
      
      @user.name        = user_params[:user_name]
      
      if@user.save!
        flash[:info]      = { title: "SUCCESS: ", body: "You are signed up"}
        go_to = login_index_path
      else
        account.destroy
        flash[:error]      = { title: "Hmmm", body: "Please Check email and password" }
      end
    end
    
    redirect_to go_to
  end
  
private

  def user_params
    params.require('/sign_up').permit!
  end
end
