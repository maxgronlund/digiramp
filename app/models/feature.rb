class Feature < ActiveRecord::Base
  def self.front; Feature.where(id: 1).first_or_create() end
end
