class UserMailer < ActionMailer::Base
  default from: "info@digiramp.org"

  def password_reset user
    @user           = user
    
    
    blog            = Blog.cached_find('Support')
    blog_post       = BlogPost.cached_find( "RESET EMAIL" , blog )
    @reset_link     = url_for( controller: 'password_resets', action: 'edit', id: @user.password_reset_token)
    @title          = blog_post.title
    @body           = blog_post.body
    @fotter_link    = url_for( controller: 'contacts', action: 'new')
    
    mail to: @user.email, subject: "reset password"
  end
  
  def invite_new_user_to_account user_id, title, body
     @user         = User.cached_find(user_id)
     @body         = body
     
     
     mail to: @user.email,  subject: title
  end
  
  def invite_existing_user_to_account user_id, account_id, invitation
    @user = User.cached_find(user_id)
    mail to: @user.email, subject: "You are invited to an account on DigiRAMP"
  end
  
  def invite_existing_user_to_catalog user_id , title, body, catalog_id 
    #puts '-----------------------------------------------------------------------------'
    #puts 'invite_existing_user_to_catalog'
    #puts '-----------------------------------------------------------------------------'
    @user       = User.cached_find(user_id)
    @title      = title
    @body       = body
    @catalog    = Catalog.cached_find(catalog_id)
    mail to: @user.email, subject: title
    puts ' SUCCESS '
  end
  
  def invite_new_user_to_catalog user_id , title, body , catalog_id
    #puts '-----------------------------------------------------------------------------'
    #puts 'invite_new_user_to_catalog'
    #puts '-----------------------------------------------------------------------------'
    @user       = User.cached_find(user_id)
    @title      = title
    @body       = body
    @catalog    = Catalog.cached_find(catalog_id)
    mail to: @user.email, subject: title
  end

end
