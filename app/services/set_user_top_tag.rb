# SetUserTopTag.process user

class SetUserTopTag
  
  
  def self.process user
    top = 0
    if user.writer
      top += 1
    end
    if user.author
      top += 1
    end
    if user.producer
      top += 1
    end
    if user.composer
      top += 1
    end
    if user.remixer
      top += 1
    end
    if user.musician
      top += 1
    end
    if user.dj
      top += 1
    end
    if user.artist
      top += 1
    end
    
    case top
    when 0
      user.top_tag = 'user-top-margin-0'
    when 1
      user.top_tag = 'user-top-margin-1'
    when 2
      user.top_tag = 'user-top-margin-2'
    when 3
      user.top_tag = 'user-top-margin-3'
    when 4
      user.top_tag = 'user-top-margin-4'
    when 5
      user.top_tag = 'user-top-margin-5'
    when 6
      user.top_tag = 'user-top-margin-6'
    when 7
      user.top_tag = 'user-top-margin-7'
    when 8
      user.top_tag = 'user-top-margin-8'
    end
  end
  
  
end