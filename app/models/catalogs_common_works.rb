class CatalogsCommonWorks < ActiveRecord::Base
  belongs_to :catalog
  belongs_to :common_work
end
