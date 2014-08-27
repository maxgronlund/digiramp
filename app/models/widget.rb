class Widget < ActiveRecord::Base
  belongs_to :catalog
  belongs_to :account
end
