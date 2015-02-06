class CmsPage < ActiveRecord::Base
  belongs_to :user
  has_many :cms_sections
  has_many :comments,        as: :commentable,          dependent: :destroy
end
