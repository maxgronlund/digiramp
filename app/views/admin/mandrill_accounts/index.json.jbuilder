json.array!(@admin_mandrill_accounts) do |admin_mandrill_account|
  json.extract! admin_mandrill_account, :id, :account_id, :notes, :custom_quota
  json.url admin_mandrill_account_url(admin_mandrill_account, format: :json)
end
