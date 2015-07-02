class UpdateForeignKeys < ActiveRecord::Migration
  def change
    
    #remove_foreign_key  :stakes, :common_works
    #remove_foreign_key  :stakes, :recordings
    remove_foreign_key  :stakes, :users
    remove_foreign_key  :stakes, :accounts
    add_foreign_key     :stakes, :accounts, on_delete: :cascade
    
    remove_foreign_key  :account_features,        :plans
    add_foreign_key     :account_features,        :plans                                      , on_delete: :cascade
    
    remove_foreign_key  :client_invitations,      :client_groups
    add_foreign_key     :client_invitations,      :client_groups                              , on_delete: :cascade
    
    remove_foreign_key  :coupons,                 :accounts
    remove_foreign_key  :coupons,                 :plans
    remove_foreign_key  :coupons,                 :sales_coupon_batches 
    
    remove_foreign_key  :invoices,                :users
    remove_foreign_key  :invoices,                :accounts 
    add_foreign_key     :invoices,                :accounts                                   , on_delete: :cascade
    
    remove_foreign_key  :payment_sources,         :subscriptions     
    remove_foreign_key  :payment_sources,         :users
    
    remove_foreign_key  :playlist_emails,         :accounts
    add_foreign_key     :playlist_emails,         :accounts                                   , on_delete: :cascade
    remove_foreign_key  :playlist_emails,         :playlists 
    add_foreign_key     :playlist_emails,         :playlists                                  , on_delete: :cascade
    
    remove_foreign_key  :recording_downloads,     :recordings
    remove_foreign_key  :recording_downloads,     :shop_order_items
    remove_foreign_key  :recording_downloads,     :shop_products
    remove_foreign_key  :recording_downloads,     :users 
    add_foreign_key     :recording_downloads,     :users                                      , on_delete: :cascade
    
    remove_foreign_key  :recording_ipis,          :accounts
    add_foreign_key     :recording_ipis,          :accounts                                   , on_delete: :cascade
    
    
    
    
    remove_foreign_key  :shop_orders,             :users
    remove_foreign_key  :shop_products,           :accounts
    remove_foreign_key  :shop_products,           :users    
    
    remove_foreign_key  :shop_stripe_transfers,   :users
    remove_foreign_key  :shop_stripe_transfers,   :accounts
    add_foreign_key     :shop_stripe_transfers,   :accounts                                   , on_delete: :cascade
    
    

    
    #remove_foreign_key  :payment_sources,         :subscriptions  
    #remove_foreign_key  :subscriptions,           :plans
    #remove_foreign_key  :subscriptions,           :coupons
    #remove_foreign_key  :shop_orders,             :coupons 
    #remove_foreign_key  :sales_coupon_batches,    :users
    #remove_foreign_key  :recording_downloads,     :shop_order_items
    #remove_foreign_key  :recording_downloads,     :recordings
    #remove_foreign_key  :recording_downloads,     :shop_products
    #remove_foreign_key  :account_features,        :plans
    #remove_foreign_key  :coupons,                 :plans
    #remove_foreign_key  :coupons,                 :sales_coupon_batches
    #remove_foreign_key  :recording_downloads,     :shop_products
  end
end
