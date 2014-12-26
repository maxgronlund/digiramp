class DigirampAd < ActiveRecord::Base
  
  mount_uploader :image, DigirampAdUploader
  
  BUTTON_STYLES = ['btn btn-default', 'btn btn-warning', 'btn btn-danger', 'btn btn-primary', 'btn btn-default btn-xs', 'btn btn-warning btn-xs', 'btn btn-danger btn-xs', 'btn btn-primary btn-xs']
  BUTTON_ICONS = ['no icon', 'fa fa-eye', 'fa fa-check', 'fa fa-sign-in', 'fa fa-music', 'fa fa-star' ]
end
