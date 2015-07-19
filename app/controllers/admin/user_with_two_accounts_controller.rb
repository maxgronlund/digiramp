class Admin::UserWithTwoAccountsController < ApplicationController
  before_action :admin_only
  def index
    @users = []
    User.find_each do |user|
      accounts = Account.where(user_id: user.id)
      if accounts.count > 1
        @users << {user: user, accounts: accounts}

      end
    end
  end
  
  def destroy

    to_account = Account.cached_find(params[:id])
    
    Account.where(user_id: to_account.user_id).each do |from_account|
      unless to_account.id == from_account.id
        copy_assets from_account, to_account
        from_account.destroy!
      end
    end
    user = to_account.user
    user.current_account_id = to_account.id
    user.save!
    redirect_to :back
  end
  
  private
  
  def copy_assets from_account, to_account
    
    from_account.recordings.update_all(account_id: to_account.id)
    from_account.artworks.update_all(account_id: to_account.id)
    from_account.recording_ipis.update_all(account_id: to_account.id)
    from_account.projects.update_all(account_id: to_account.id)
    from_account.stakes.update_all(account_id: to_account.id)
    from_account.documents.update_all(account_id: to_account.id)
    from_account.attachments.update_all(account_id: to_account.id)
    from_account.playlists.update_all(account_id: to_account.id)
    from_account.common_works.update_all(account_id: to_account.id)
    from_account.ipi_codes.update_all(account_id: to_account.id)
    from_account.import_batches.update_all(account_id: to_account.id)
    from_account.catalogs.update_all(account_id: to_account.id)
    from_account.catalog_users.update_all(account_id: to_account.id)
    from_account.opportunities.update_all(account_id: to_account.id)
    from_account.playlist_key_users.update_all(account_id: to_account.id)
    from_account.widgets.update_all(account_id: to_account.id)
    from_account.playbacks.update_all(account_id: to_account.id)
    from_account.likes.update_all(account_id: to_account.id)
    from_account.campaigns.update_all(account_id: to_account.id)
    from_account.campaign_events.update_all(account_id: to_account.id)
    from_account.contracts.update_all(account_id: to_account.id)

    from_account.creative_projects.update_all(account_id: to_account.id)
    from_account.products.update_all(account_id: to_account.id)
    from_account.stripe_transfers.update_all(account_id: to_account.id)
    from_account.artworks.update_all(account_id: to_account.id)
    
    from_account.clients.destroy_all
    from_account.client_invitations.destroy_all
    
    comments = Comment.where(commentable_type: 'Account', commentable_id: from_account.id)
    comments.update_all(commentable_id: to_account.id)
    
  end
end
