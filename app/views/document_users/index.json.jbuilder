json.array!(@document_users) do |document_user|
  json.extract! document_user, :id, :document_id, :user_id, :account_id, :can_edit, :should_sign, :email, :signature, :signature_image, :status
  json.url document_user_url(document_user, format: :json)
end
