json.array!(@mandrill_testers) do |mandrill_tester|
  json.extract! mandrill_tester, :id, :email, :subject, :message
  json.url mandrill_tester_url(mandrill_tester, format: :json)
end
