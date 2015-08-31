json.array!(@user_configurations) do |user_configuration|
  json.extract! user_configuration, :id, :user_id, :i_want_to_upload_music, :i_am_looking_for_a_publisher, :register_me_as_a_publisher, :i_have_a_publisher, :i_want_to_sell_goods, :i_want_to_sell_services, :i_want_to_collaborate, :i_want_to_receive_money_directly, :i_want_to_manage_users_and_catalogs, :dont_ask_me_again, :configured
  json.url user_configuration_url(user_configuration, format: :json)
end
