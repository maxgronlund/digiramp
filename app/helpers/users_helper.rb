module UsersHelper
  
  #def admin_users_path_backbone *args
  #  admin_users_path(*args)+"#admin_users"
  #end
  
  def can_edit?
    user_signed_in? && current_user.super?
  end
  
  def user_signed_in?
    current_user != nil
  end
  
  def current_user_is_max?
    can_edit? && current_user.email == 'max@synthmax.dk'
  end
  
  def profile_path_for user
    path = user_path( user)
  end
  
  def avatar_url(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      default_url = "#{root_url}images/guest.png"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
    end
  end
  
  
  
  
  def user_can_manage_assets account, user
    return true if account.create_recording_ids.include?        current_user.id
    return true if   account.read_recording_ids.include?        current_user.id
    return true if account.update_recording_ids.include?        current_user.id
    return true if account.delete_recording_ids.include?        current_user.id
    return true if account.create_recording_ipi_ids.include?    current_user.id
    return true if   account.read_recording_ipi_ids.include?    current_user.id
    return true if account.update_recording_ipi_ids.include?    current_user.id
    return true if account.delete_recording_ipi_ids.include?    current_user.id
    return true if account.create_file_ids.include?             current_user.id
    return true if   account.read_file_ids.include?             current_user.id
    return true if account.update_file_ids.include?             current_user.id
    return true if account.delete_file_ids.include?             current_user.id
    return true if account.create_common_work_ids.include?      current_user.id
    return true if   account.read_common_work_ids.include?      current_user.id
    return true if account.update_common_work_ids.include?      current_user.id
    return true if account.delete_common_work_ids.include?      current_user.id
    return true if account.create_common_work_ipi_ids.include?  current_user.id
    return true if   account.read_common_work_ipi_ids.include?  current_user.id
    return true if account.update_common_work_ipi_ids.include?  current_user.id
    return true if account.delete_common_work_ipi_ids.include?  current_user.id
    return false
  end
  
  def user_can_manage_users account, user
    return true if account.create_account_user_ids.include?     current_user.id
    return true if account.read_account_user_ids.include?       current_user.id
    return true if account.update_account_user_ids.include?     current_user.id
    return true if account.delete_account_user_ids.include?     current_user.id
    return false
  end
  
  def user_can_manage_common_works account, user
    return true if account.create_common_work_ids.include?     current_user.id
    return true if   account.read_common_work_ids.include?     current_user.id
    return true if account.update_common_work_ids.include?     current_user.id
    return true if account.delete_common_work_ids.include?     current_user.id
    
    return true if account.create_common_work_ipi_ids.include?     current_user.id
    return true if   account.read_common_work_ipi_ids.include?     current_user.id
    return true if account.update_common_work_ipi_ids.include?     current_user.id
    return true if account.delete_common_work_ipi_ids.include?     current_user.id
    return false
    
    
  end
  
  def user_can_manage_recordings account, user
    #return true if account.create_recording_ids.include?     current_user.id
    return true if   account.read_recording_ids.include?     current_user.id
    return true if account.update_recording_ids.include?     current_user.id
    return true if account.delete_recording_ids.include?     current_user.id
    
    return true if account.create_recording_ipi_ids.include?     current_user.id
    return true if   account.read_recording_ipi_ids.include?     current_user.id
    return true if account.update_recording_ipi_ids.include?     current_user.id
    return true if account.delete_recording_ipi_ids.include?     current_user.id
    return false
  end
  
  def user_can_manage_catalogs account, user
    return true if account.create_catalog_ids.include?     current_user.id
    return true if   account.read_catalog_ids.include?     current_user.id
    return true if account.update_catalog_ids.include?     current_user.id
    return true if account.delete_catalog_ids.include?     current_user.id
    return false
  end
  
  def user_can_add_music account, user
    return true if account.create_recording_ids.include?     current_user.id
    return false
  end
  
  def user_can_manage_files account, user
    return true if account.create_file_ids.include?     current_user.id
    return true if   account.read_file_ids.include?     current_user.id
    return true if account.update_file_ids.include?     current_user.id
    return true if account.delete_file_ids.include?     current_user.id
    return false
  end
  
  def user_can_manage_playlists account, user
    return true if account.create_playlist_ids.include?     current_user.id
    return true if   account.read_playlist_ids.include?     current_user.id
    return true if account.update_playlist_ids.include?     current_user.id
    return true if account.delete_playlist_ids.include?     current_user.id
    return false
  end
  
  
  
  
end
