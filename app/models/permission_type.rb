class PermissionType < ActiveRecord::Base
  ## Usage PermissionType.get('common_works')
  ## Will find or create PermissionType with identifier 'common_works'
  
  has_many :permissions, dependent: :destroy
  
  validates_uniqueness_of      :identifier
  def self.get                  identifier
    where(          identifier: identifier)
   .first_or_create identifier: identifier,
                         title: identifier.humanize
  end
end