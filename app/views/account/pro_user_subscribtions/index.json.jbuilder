json.array!(@pro_user_subscribtions) do |pro_user_subscribtion|
  json.extract! pro_user_subscribtion, :id, :email, :user_id, :account_id
  json.url pro_user_subscribtion_url(pro_user_subscribtion, format: :json)
end
