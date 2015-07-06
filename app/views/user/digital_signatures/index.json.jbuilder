json.array!(@digital_signatures) do |digital_signature|
  json.extract! digital_signature, :id, :uuid, :user_id, :account_id, :document_id, :document_type, :image
  json.url digital_signature_url(digital_signature, format: :json)
end
