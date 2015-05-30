module UsersHelper
  
  #def admin_users_path_backbone *args
  #  admin_users_path(*args)+"#admin_users"
  #end
  
  #def can_edit?
  #  user_signed_in? && current_user.super?
  #end
  #
  #def user_signed_in?
  #  current_user != nil
  #end
  #
  #def current_user_is_max?
  #  can_edit? && current_user.email == 'max@synthmax.dk'
  #end
  
  def profile_path_for user
    if cms_page = CmsPage.where(id: user.default_cms_page_id).first
      return user_cms_page_path(user, cms_page)
    else
      return user_path( user )
    end
  end
  
  #def profile_page
  #  if cms_page = CmsPage.where(id: self.default_cms_page_id).first
  #    return user_cms_page_path(self, cms_page)
  #  else
  #    return user_path(self)
  #  end
  #end
  
  def avatar_url(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      default_url = "#{root_url}images/guest.png"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
    end
  end
  
  def create_catalog_assets(current_catalog_user)
    true
  end
  
  
  
  
  
  
  #def user_can_manage_assets account, user
  #  return true if account.create_recording_ids.include?        current_user.id
  #  return true if   account.read_recording_ids.include?        current_user.id
  #  return true if account.update_recording_ids.include?        current_user.id
  #  return true if account.delete_recording_ids.include?        current_user.id
  #  return true if account.create_recording_ipi_ids.include?    current_user.id
  #  return true if   account.read_recording_ipi_ids.include?    current_user.id
  #  return true if account.update_recording_ipi_ids.include?    current_user.id
  #  return true if account.delete_recording_ipi_ids.include?    current_user.id
  #  return true if account.create_file_ids.include?             current_user.id
  #  return true if   account.read_file_ids.include?             current_user.id
  #  return true if account.update_file_ids.include?             current_user.id
  #  return true if account.delete_file_ids.include?             current_user.id
  #  return true if account.create_common_work_ids.include?      current_user.id
  #  return true if   account.read_common_work_ids.include?      current_user.id
  #  return true if account.update_common_work_ids.include?      current_user.id
  #  return true if account.delete_common_work_ids.include?      current_user.id
  #  return true if account.create_common_work_ipi_ids.include?  current_user.id
  #  return true if   account.read_common_work_ipi_ids.include?  current_user.id
  #  return true if account.update_common_work_ipi_ids.include?  current_user.id
  #  return true if account.delete_common_work_ipi_ids.include?  current_user.id
  #  return false
  #end
  #
  #def user_can_manage_users account, user
  #  return true if account.create_user_ids.include?     current_user.id
  #  return true if   account.read_user_ids.include?       current_user.id
  #  return true if account.update_user_ids.include?     current_user.id
  #  return true if account.delete_user_ids.include?     current_user.id
  #  return false
  #end
  #
  #def user_can_manage_common_works account, user
  #  return true if account.create_common_work_ids.include?     current_user.id
  #  return true if   account.read_common_work_ids.include?     current_user.id
  #  return true if account.update_common_work_ids.include?     current_user.id
  #  return true if account.delete_common_work_ids.include?     current_user.id
  #  
  #  return true if account.create_common_work_ipi_ids.include?     current_user.id
  #  return true if   account.read_common_work_ipi_ids.include?     current_user.id
  #  return true if account.update_common_work_ipi_ids.include?     current_user.id
  #  return true if account.delete_common_work_ipi_ids.include?     current_user.id
  #  return false
  #  
  #  
  #end
  #
  #def user_can_manage_recordings account, user
  #  #return true if account.create_recording_ids.include?     current_user.id
  #  return true if   account.read_recording_ids.include?     current_user.id
  #  return true if account.update_recording_ids.include?     current_user.id
  #  return true if account.delete_recording_ids.include?     current_user.id
  #  
  #  return true if account.create_recording_ipi_ids.include?     current_user.id
  #  return true if   account.read_recording_ipi_ids.include?     current_user.id
  #  return true if account.update_recording_ipi_ids.include?     current_user.id
  #  return true if account.delete_recording_ipi_ids.include?     current_user.id
  #  return false
  #end
  #
  #def user_can_manage_catalogs account, user
  #  return true if account.create_catalog_ids.include?     current_user.id
  #  return true if   account.read_catalog_ids.include?     current_user.id
  #  return true if account.update_catalog_ids.include?     current_user.id
  #  return true if account.delete_catalog_ids.include?     current_user.id
  #  return false
  #end
  #
  #def user_can_add_music account, user
  #  return true if account.create_recording_ids.include?     current_user.id
  #  return false
  #end
  #
  #def user_can_manage_files account, user
  #  return true if account.create_file_ids.include?     current_user.id
  #  return true if   account.read_file_ids.include?     current_user.id
  #  return true if account.update_file_ids.include?     current_user.id
  #  return true if account.delete_file_ids.include?     current_user.id
  #  return false
  #end
  #
  #def user_can_manage_playlists account, user
  #  return true if account.create_playlist_ids.include?     current_user.id
  #  return true if   account.read_playlist_ids.include?     current_user.id
  #  return true if account.update_playlist_ids.include?     current_user.id
  #  return true if account.delete_playlist_ids.include?     current_user.id
  #  return false
  #end
  
  def on_users_account
    true
  end
  
  def account_owner?
    begin
      return true if current_user && current_user.account_id == @account.id
    rescue
      cookies.delete(:auth_token)
      current_user = nil
    end
    return false
  end
  
  def can_edit_account?
    if @account
      return true if current_user && current_user.account_id == @account.id
      return true if current_user.super?
    end
    return false
    
  end

  
  
  
  
end
