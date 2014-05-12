class Issue < ActiveRecord::Base
  belongs_to :user
  
  mount_uploader :image, LogoUploader
  
  OSS = ["Windows 7",
        "Windows XP",
        "Windows 8",
        "OS X 10.0 Cheetah",
        "OS X 10.1 Puma",
        "OS X 10.2 Jaguar",
        "OS X 10.3 Panther",
        "OS X 10.4 Tiger",
        "OS X 10.5 Leopard",
        "OS X 10.6 Snow Leopard",
        "OS X 10.7 Lion",
        "OS X 10.8 Mountain Lion",
        "OS X 10.9 Mavericks"]
  SYMPTOMS = ['Error 422', 'Error 500', 'Missing Buttons', 'Styling', 'Other']
  BROWSERS = ['Safari', 'Chrome', 'Firefox', 'IE', 'Opera', 'Other']
  
  STATUS = ['New', 'Confirmed', 'In progress', 'Resolved', 'Closed']
end
