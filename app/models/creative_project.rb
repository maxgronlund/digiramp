class CreativeProject < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  
  has_many :creative_project_users
  has_many :creative_project_roles, dependent: :destroy
  has_many :creative_project_resources, dependent: :destroy
  has_many :comments,        as: :commentable,          dependent: :destroy
  
  validates_presence_of :title
  
  after_create :add_creative_project_user
  after_commit :flush_cache
  
  # add the manager as a creative_project_user
  def add_creative_project_user
    creative_project_role   = CreativeProjectRole.create( creative_project_id: self.id, 
                                                          role: 'project manager'
                                                          )
                                                          
    creative_project_user   = CreativeProjectUser.create( user_id: self.user_id, 
                                                          creative_project_role_id: creative_project_role.id, 
                                                          creative_project_id: self.id,
                                                          approved_by_project_manager: true,
                                                          approved_by_user: true
                                                        )                                                   
  end

  def self.cached_find(id)
    Rails.cache.fetch([name, id]) { find(id) }
  end
  
  def open_positions role
    positions = creative_project_roles.where(role: role).count
    self.creative_project_roles.where(role: role).each do |creative_project_role|
      positions -= 1 if creative_project_role.taken?
    end
    positions
  end
  
  def update_looking_for
    self.writers                  = self.creative_project_roles.where(role: 'writer').count                 > 0
    self.composers                = self.creative_project_roles.where(role: 'composer').count               > 0
    self.musicians                = self.creative_project_roles.where(role: 'musician').count               > 0
    self.vocals                   = self.creative_project_roles.where(role: 'vocal').count                  > 0
    self.dancers                  = self.creative_project_roles.where(role: 'dancer').count                 > 0
    self.live_performers          = self.creative_project_roles.where(role: 'live performer').count         > 0
    self.producers                = self.creative_project_roles.where(role: 'producer').count               > 0
    self.studio_facilities        = self.creative_project_roles.where(role: 'studio facility').count        > 0
    self.financial_services       = self.creative_project_roles.where(role: 'financial service').count      > 0
    self.legal_services           = self.creative_project_roles.where(role: 'legal service').count          > 0
    self.publishers               = self.creative_project_roles.where(role: 'publisher').count              > 0
    self.remixers                 = self.creative_project_roles.where(role: 'remixer').count                > 0
    self.audio_engineers          = self.creative_project_roles.where(role: 'audio engineer').count         > 0
    self.video_artists            = self.creative_project_roles.where(role: 'video artist').count           > 0
    self.graphic_artists          = self.creative_project_roles.where(role: 'graphic artist').count         > 0
    self.other                    = self.creative_project_roles.where(role: 'other').count                  > 0
    save!
    ap self
  end

private 

  def flush_cache
    Rails.cache.delete([self.class.name, id])
  end
end
