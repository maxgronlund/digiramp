class Opportunity < ActiveRecord::Base
  include PublicActivity::Common
  has_many        :opportunity_invitations
  has_many        :music_requests, dependent: :destroy
  has_many        :opportunity_users, dependent: :destroy
  belongs_to      :account
  after_commit    :flush_cache
  
  validates_presence_of :title
  include PgSearch
  pg_search_scope :search_opportunity, against: [:title, :body, :kind, :territory], :using => [:tsearch]
  
  
  
  #create_table "opportunities", force: true do |t|
  #  t.string   "title"
  #  t.text     "body"
  #  t.string   "kind"
  #  t.string   "budget",     default: ""
  #  t.date     "deadline"
  #  t.integer  "account_id"
  #  t.datetime "created_at"
  #  t.datetime "updated_at"
  #  t.string   "territory",  default: ""
  #end
  #
  
  
  
  
  
  def submission_count
    return submissions.size if submissions
    0
  end
  
  def submissions
    MusicSubmission.where( music_request_id: music_request_ids)
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  
  
  def self.search(  query)
    if query.present?
      return Opportunity.search_opportunity(query)
    else
      return all
    end
  end
  
  
private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end

