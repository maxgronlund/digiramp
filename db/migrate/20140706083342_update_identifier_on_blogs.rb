class UpdateIdentifierOnBlogs < ActiveRecord::Migration
  def change
    
    change_column_default :blogs, :title, ''
    change_column_default :blogs, :body, ''
    change_column_default :blogs, :identifier, ''
    
    Blog.all.each do |blog|
      blog.check_identifier
    end
    
    
  end
end
