class Blog < ActiveRecord::Base
  
  has_many :blog_posts
  LAYOUTS = %w[layout_3_9 layout_4_8 layout_4_4_4 layout_6_6 layout_8_4 layout_9_3 layout_12 badges3 ]
  validates_presence_of :title

  def self.home; Blog.where(identifier: 'Homepage Content').first_or_create(identifier: 'Homepage Content', title: 'Homepage Content' ) end
  def self.about; Blog.where(identifier: 'About Page Content').first_or_create(identifier: 'About Page Content', title: 'About Content' ) end
  def self.pricing; Blog.where(identifier: 'Pricing Page Content').first_or_create(identifier: 'Pricing Page Content', title: 'Pricing Content' ) end
  def self.help; Blog.where(identifier: 'Help').first_or_create(identifier: 'Help', title: 'Help', layout:  'layout_3_9') end
  def self.common_works_help; Blog.where(identifier: 'Help on Common Works').first_or_create(identifier: 'Help on Common Works', title: 'Help on Common Works', layout:  'layout_3_9') end
  def self.import_wizard; Blog.where(identifier: 'Import Wizard').first_or_create(identifier: 'Import Wizard', title: 'Import Wizard' ) end
  
  
  def self.welcome; Blog.where(identifier: 'Welcome').first_or_create(identifier: 'Welcome', title: 'Welcome' ) end
  def self.add_content; Blog.where(identifier: 'Add Content').first_or_create(identifier: 'Add Content', title: 'Add Content' ) end
  def self.works; Blog.where(identifier: 'Works').first_or_create(identifier: 'Works', title: 'Works' ) end
  def self.add_recording; Blog.where(identifier: 'Add Recording').first_or_create(identifier: 'Add Recording', title: 'Add Recording' ) end
  def self.selling_points; Blog.where(identifier: 'Selling Points').first_or_create(identifier: 'Selling Points', title: 'Selling Points' ) end
  
  def self.account_users; Blog.where(identifier: 'Account Users').first_or_create(identifier: 'Account Users', title: 'Account Users' ) end
  def self.assets; Blog.where(identifier: 'Assets').first_or_create(identifier: 'Assets', title: 'Assets' ) end
  def self.collect; Blog.where(identifier: 'Collect').first_or_create(identifier: 'Collect', title: 'Collect' ) end
  def self.promotion; Blog.where(identifier: 'Promotion').first_or_create(identifier: 'Promotion', title: 'Promotion' ) end
  def self.drm; Blog.where(identifier: 'DRM').first_or_create(identifier: 'DRM', title: 'DRM' ) end
end
