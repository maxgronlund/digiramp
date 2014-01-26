class AscapSearchWriter < ActiveRecord::Base
  has_many :ascap_search_writer_results
  #attr_accessible :search_query
  validates :search_query, uniqueness: true
end
