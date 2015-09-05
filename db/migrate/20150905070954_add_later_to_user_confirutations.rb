class AddLaterToUserConfirutations < ActiveRecord::Migration
  def change
    add_column :user_configurations, :i_want_to_promote_my_music_later, :boolean, default: false
    add_column :user_configurations, :i_want_to_sell_music_later, :boolean, default: false
    add_column :user_configurations, :i_want_to_get_my_music_into_films_and_tv_later, :boolean, default: false
    add_column :user_configurations, :i_want_to_find_and_listen_to_music_later, :boolean, default: false
    add_column :user_configurations, :i_want_to_sell_goods_later, :boolean, default: false
    add_column :user_configurations, :i_want_to_offer_services_later, :boolean, default: false
    add_column :user_configurations, :i_want_to_collaborate_later, :boolean, default: false
    add_column :user_configurations, :i_want_to_manage_users_and_catalogs_later, :boolean, default: false
    add_column :user_configurations, :i_want_to_build_custom_web_pages_later, :boolean, default: false
                
    add_column :user_configurations, :i_want_to_connect_with_people, :boolean, default: false
    add_column :user_configurations, :i_want_to_connect_with_people_later, :boolean, default: false
  end
end



