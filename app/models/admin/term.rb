class Admin::Term < ActiveRecord::Base
  
  include PgSearch
  pg_search_scope :search_term, against: [:title, :body], :using => [:tsearch]
  
  
  def self.search( query)
    if query.present?
      return Admin::Term.search_term(query)
    else
      return all
    end
  end
  
  
end
