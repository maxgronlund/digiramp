class UpdateUserNameForUrl < ActiveRecord::Migration
  def change
    
    remove_column :users, :user_name, :string
    add_column :users, :user_name, :string, default: ''
    
    User.all.each_with_index do |user, index|
      
      
      
      user.update_meta
      if user.user_name.to_s == ''
        
        begin
          user.user_name = user.email.gsub('@', '-').gsub('.', '-').downcase.strip
          user.slug      = nil
          user.save!
          puts user.friendly_id
        rescue
          #user.user_name = user.email.gsub('@', '-').gsub('.', '-').downcase.strip + index.to_s
          #user.slug      = nil
          #user.save!
          #puts user.friendly_id
          ap user
        end
          
        #user.slug = nil
        #user.save!
      end
      #unless user.save!
      #  ap user
      #end
      
      #user.email = user.email.strip.downcase
      #user.save!
      #if users = User.where(email: user.email).count > 1
      #  ap user
      #  #users.each_with_index do |usr, index|
      #  #  ap usr
      #  #  usr.name = user.name + '_' + index.to_s
      #  #  ap usr
      #  #  #usr.save!
      #  #end
      #end
      #
      

      #user.user_name = user.email.gsub('@', '-').gsub('.', '-').downcase.strip
      #user.slug      = nil
      #
      #if users = User.where(name: user.name).count > 1
      #  ap user
      #  users.each_with_index do |usr, index|
      #    ap usr
      #    usr.name = user.name + '_' + index.to_s
      #    usr.save!
      #  end
      #end
      
      #user.save!
      #
      #puts user.friendly_id
      #
    end
    
    
  end
end


#max@pixlsonrails.com
#max@pixelonrails.com