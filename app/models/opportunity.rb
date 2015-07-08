class Opportunity < ActiveRecord::Base
  has_paper_trail
  include PublicActivity::Common
  has_many  :opportunity_invitations
  has_many  :music_requests, dependent: :destroy
  
  accepts_nested_attributes_for :music_requests, :reject_if => :all_blank, :allow_destroy => true
  
  
  has_many :opportunity_users, dependent: :destroy
  has_many :selected_opportunities,   dependent: :destroy
  has_many :opportunity_evaluations, dependent: :destroy
  has_many :opportunity_views, dependent: :destroy
  has_many :digiramp_emails

  
  
  belongs_to      :account
  after_commit    :flush_cache
  
  validates_presence_of :title
  
  mount_uploader :image, ArtworkUploader
  
  scope :public_opportunities,  ->  { where( public_opportunity: true).order('deadline desc')  }
  
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
  
  before_create :init_fields


  
  def check_default_image
    if self.image_url == "/assets/fallback/artwork.jpg" || self.image.nil?
      prng      = Random.new
      random_id =  prng.rand(10)

      if random_id < 10
        random_id = '0' + random_id.to_s 
      end
      self.image = File.open(Rails.root.join('app', 'assets', 'images', "opportunities/default_#{random_id.to_s}.jpg"))
      self.image.recreate_versions!
      self.save!
    end
  end
  
  def user
    if self.account && self.account.user
      return self.account.user
    end
    nil
      
  end
  
  def init_fields
    self.uuid = UUIDTools::UUID.timestamp_create().to_s
  end
  
  def submission_count
    return submissions.size if submissions
    0
  end
  
  def submissions
    MusicSubmission.where( music_request_id: music_request_ids)
  end

  def self.search(  query)
    if query.present?
      return Opportunity.search_opportunity(query)
    else
      return all
    end
  end
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def notify_oppurtunity_mail_subscribers
    
    #return unless self.public_opportunity
    
    if email_group = EmailGroup.where( identifier: 'opportunities').first
      
      #opportunity_url  = url_for( controller: '/public_opportunities', action: 'show', id: @digiramp_email.opportunity_id)
                                    
      digiramp_email = email_group.digiramp_emails.create( opportunity_id: self.id,
                                                           subject:        self.title,
                                                           layout:         'opportunity_email',
                                                           title_1:        self.title,
                                                           title_2:        '',
                                                           title_3:        '',
                                                           body_1:         self.body,
                                                           body_2:         '',
                                                           body_3:         '',
                                                           image_1:        self.image,          
                                                           link_1:         '',  
                                                           link_1_title:   '',  
                                                           delivered:      true,     
                                                           freeze_emails:  true ,
                                                           kind:           self.kind,
                                                           budget:         self.budget,
                                                           territory:      self.territory,    
                                                           uuid:           UUIDTools::UUID.timestamp_create().to_s,
                                                           deadline:       self.deadline        
                                                         )

      #DigirampEmailMailer.delay.opportunity_created( digiramp_email.id )
      
      digiramp_email.send_opportunity_emails
      self.opportunity_email_send = true
      self.save!
        
    end        
    

  end
private
  
  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end

