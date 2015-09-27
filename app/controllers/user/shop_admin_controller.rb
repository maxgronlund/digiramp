class User::ShopAdminController < ApplicationController
  before_action :access_user
  def index
    if Rails.env.test?
       @shop_products= @user.products 
       return
    elsif @user.has_enabled_shop 
      #document_templates
      # @email_groups = EmailGroup.where(subscripeable: true)
      @shop_products = @user.products
    else
      redirect_to user_user_create_shop_index_path(@user)
    end
    
  end
  
  
  private
    # secure the latest contract templates for a given 
    # product category is copied to the account
    #def document_templates
    #  if account = @user.account
    #    
    #    documents = account.documents.where(tag: 'Recording', document_type: 'Legal')
    #    if documents.empty?
    #      documents = Document.clone_templates( @user.account.id,   'Recording', 'Legal' ) 
    #    end
    #    
    #    documents = account.documents.where(tag: 'Physical product', document_type: 'Legal')
    #    if documents.empty?
    #      documents = Document.clone_templates( @user.account.id,   'Physical product', 'Legal' )                     
    #    end  
    #    
    #    documents = account.documents.where(tag: 'Service', document_type: 'Legal')
    #    if documents.empty?
    #      documents = Document.clone_templates( @user.account.id,   'Service', 'Legal' )                     
    #    end   
    #    
    #    documents = account.documents.where(tag: 'Streaming', document_type: 'Legal')
    #    if documents.empty?
    #      documents = Document.clone_templates( @user.account.id,   'Streaming', 'Legal' )                     
    #    end                        
    #    
    #  end
    #end
end
