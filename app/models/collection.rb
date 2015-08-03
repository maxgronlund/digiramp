class Collection < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :collectable, polymorphic: true
  belongs_to :selectable, polymorphic: true
end
