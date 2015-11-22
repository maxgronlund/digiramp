# UserSearchField.process

# optimization: only search on one field
class UserSearchField
  def self.process user
    #ap '------------------------------'
    #ap user.full_name
    #ap user.user_name
    #ap user
    search_field_content = []
    search_field_content <<   user.profession           if user.profession
    search_field_content <<   user.profile              if user.profile
    search_field_content <<   user.get_full_name.strip  unless user.get_full_name.strip.blank?
    search_field_content <<   user.slug
    search_field_content <<   user.email << ' '
    search_field_content <<   user.user_name << ' '
    search_field_content <<  'writer '                if user.writer
    search_field_content <<  'author '                if user.author
    search_field_content <<  'producer '              if user.producer
    search_field_content <<  'composer '              if user.composer
    search_field_content <<  'remixer '               if user.remixer
    search_field_content <<  'musician '              if user.musician
    search_field_content <<  'dj '                    if user.dj
    search_field_content <<  'artist '                if user.artist
    search_field_content <<  user.country             if user.country
    search_field_content <<  user.city                if user.city
    user.user_emails.each { |user_email| search_field_content << user_email.email + ' ' }
    user.search_field = search_field_content.join(" ")
  end
  
end

# c.mac@whosthehottestrapper.com
