class ItemLike < ActiveRecord::Base
  belongs_to :user
  belongs_to :like, polymorphic: true
end
