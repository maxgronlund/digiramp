class Upload < ActiveRecord::Base
  serialize :audio_upload, Hash
end
