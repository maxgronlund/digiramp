json.array!(@issues) do |issue|
  json.extract! issue, :id, :title, :body, :image, :user_id, :account_belongs_to, :os, :browser, :link_to_page, :can_reproducd, :status, :priority, :symtom
  json.url issue_url(issue, format: :json)
end
