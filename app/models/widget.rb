class Widget < ActiveRecord::Base
  belongs_to :catalog
  belongs_to :account
  mount_uploader :image, WidgetUploader
end
