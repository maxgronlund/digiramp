class CmsPage < ActiveRecord::Base
  belongs_to :user
  has_many :cms_sections
end
