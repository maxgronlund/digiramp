json.array!(@opportunity_invitations) do |opportunity_invitation|
  json.extract! opportunity_invitation, :id, :opportunity_id, :title, :body, :invitees
  json.url opportunity_invitation_url(opportunity_invitation, format: :json)
end
