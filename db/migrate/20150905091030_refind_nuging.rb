class RefindNuging < ActiveRecord::Migration
  def change
    remove_column :user_configurations, :i_want_to_promote_my_music_later, :boolean, default: false
    remove_column :user_configurations, :i_want_to_sell_music_later, :boolean, default: false
    remove_column :user_configurations, :i_want_to_get_my_music_into_films_and_tv_later, :boolean, default: false
    remove_column :user_configurations, :i_want_to_find_and_listen_to_music_later, :boolean, default: false
    remove_column :user_configurations, :i_want_to_sell_goods_later, :boolean, default: false
    remove_column :user_configurations, :i_want_to_offer_services_later, :boolean, default: false
    remove_column :user_configurations, :i_want_to_collaborate_later, :boolean, default: false
    remove_column :user_configurations, :i_want_to_manage_users_and_catalogs_later, :boolean, default: false
    remove_column :user_configurations, :i_want_to_build_custom_web_pages_later, :boolean, default: false        
    remove_column :user_configurations, :i_want_to_connect_with_people, :boolean, default: false
    remove_column :user_configurations, :i_want_to_connect_with_people_later, :boolean, default: false
    
    
    
    add_column :user_configurations, :upload_recordings_later,                                :boolean, default: false
    add_column :user_configurations, :create_a_playlist_later,                                :boolean, default: false
    add_column :user_configurations, :invite_friends_later,                                   :boolean, default: false
    add_column :user_configurations, :post_on_facebook_later,                                 :boolean, default: false
    add_column :user_configurations, :post_on_twitter_later,                                  :boolean, default: false
    add_column :user_configurations, :register_a_publisher_later,                             :boolean, default: false
    add_column :user_configurations, :clear_a_recording_later,                                :boolean, default: false
    add_column :user_configurations, :enable_shop_later,                                      :boolean, default: false
    add_column :user_configurations, :add_a_recording_to_the_shop_later,                      :boolean, default: false
    add_column :user_configurations, :submit_to_an_opportunity_later,                         :boolean, default: false
    

  end
end
