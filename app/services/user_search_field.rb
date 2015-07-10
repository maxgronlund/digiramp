# UserSearchfield.process

# optimization: only search on one field
class UserSearchField
  def self.process user
    search_field_content = ''
    search_field_content <<   user.profession  if user.profession
    search_field_content <<  ' '
    search_field_content <<   user.profile     if user.profile
    search_field_content <<  ' '
    search_field_content <<   user.name        if user.name
    search_field_content <<  ' '
    
    search_field_content <<   user.email       if user.email
    search_field_content <<  ' '
    
    search_field_content <<   user.user_name  if user.user_name
    search_field_content <<  ' '
    
    search_field_content <<  'writer '        if user.writer
    search_field_content <<  'author '        if user.author
    search_field_content <<  'producer '      if user.producer
    search_field_content <<  'composer '      if user.composer
    search_field_content <<  'remixer '       if user.remixer
    search_field_content <<  'musician '      if user.musician
    search_field_content <<  'dj '            if user.dj
    search_field_content <<  'country '       if user.country
    search_field_content <<  'city '          if user.city
    search_field_content <<  'artist '        if user.artist
    user.search_field = search_field_content
  end
  
end

