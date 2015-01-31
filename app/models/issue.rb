class Issue < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :commentable
  
  
  include PgSearch
  pg_search_scope :search_issues, against: [ :title, 
                                      :body, 
                                      :symtom, 
                                      :browser, 
                                      :os
                                    ], :using => [:tsearch]
                                    
                                    
  
  mount_uploader :image, LogoUploader
  after_commit :flush_cache
  
  after_create :send_emails
  
  OSS = ["Windows 7",
        "Windows XP",
        "Windows 8",
        "Windows 9",
        "Windows 10",
        "OS X 10.0 Cheetah",
        "OS X 10.1 Puma",
        "OS X 10.2 Jaguar",
        "OS X 10.3 Panther",
        "OS X 10.4 Tiger",
        "OS X 10.5 Leopard",
        "OS X 10.6 Snow Leopard",
        "OS X 10.7 Lion",
        "OS X 10.8 Mountain Lion",
        "OS X 10.9 Mavericks",
        "OS X 10.10 YOSEMITE",
        "OS X 10.11 YOSEMITE",
        "iOS",
        "Android"]
  SYMPTOMS = ['Error 422', 'Error 500', 'Missing Buttons', 'Styling', 'Other']
  BROWSERS = ['Safari', 'Chrome', 'Firefox', 'IE', 'Opera', 'Other']
  
  STATUS    = ['New', 'Confirmed', 'Rejected', 'In Progress', 'Resolved', 'Closed']
  PRIORITY  = ['None', 'High', 'Medium', 'Low']
  
  scope :open,        ->    { where.not( status: ['Closed', 'Resolved'] ).order("created_at desc")  }

  
  def self.search(query)

    if query.present?
      return search_issues(query)
    else
      return Issue.all
    end

  end
  
  
  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def resolved
    #blog      = Blog.cached_find('Support')
    #blog_post = BlogPost.cached_find('ISSUE RESOLVED' , blog)
    SupportMailer.delay.issue_resolved( self.user_id, self.id)
    
  end
  
private

  def send_emails
    #blog      = Blog.cached_find('Support')
    #blog_post = BlogPost.cached_find('TICKET RECEIVED' , blog)
    SupportMailer.delay.ticket_received( self.user_id, self.id)
    
    #blog_post = BlogPost.cached_find('TICKET RECEIVED' , blog)
    #SupportMailer.delay.ticket_received( self.user_id, self.id, blog_post.id )
    
  end

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
