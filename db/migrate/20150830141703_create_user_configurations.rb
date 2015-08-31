class CreateUserConfigurations < ActiveRecord::Migration
  def change
    create_table :user_configurations do |t|
      t.integer :user_id
      t.boolean :i_want_to_promote_my_music, default: false
      t.boolean :i_want_to_sell_music, default: false
      t.boolean :i_want_to_get_my_music_into_films_and_tv
      t.boolean :i_want_find_and_listen_to_music
      #t.boolean :i_am_looking_for_a_publisher, default: false
      #t.boolean :register_me_as_a_publisher, default: false
      #t.boolean :i_have_a_publisher, default: false
      t.boolean :i_want_to_sell_goods, default: false
      t.boolean :i_want_to_offer_services, default: false
      t.boolean :i_want_to_collaborate, default: false
      #t.boolean :i_want_to_receive_money_directly, default: false
      t.boolean :i_want_to_manage_users_and_catalogs, default: false
      t.boolean :i_want_to_build_custom_web_pages, default: false
      t.boolean :dont_ask_me_again, default: false
      t.boolean :configured, default: false


      t.timestamps null: false
    end
    
    add_index :user_configurations, :user_id
    
    User.find_each do |user|
      UserConfiguration.create(user_id: user.id)
    end
  end
end
