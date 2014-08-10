class DowncaseAllUserEmails < ActiveRecord::Migration
  def change
    User.all.order(:email).each do |user|
      user.email.downcase!
      begin
        user.save!
      rescue
        puts '------------ ERROR --------------'
        User.where(email: user.email).each do |u|
          ap u
        end
      end
    end
  end
end
