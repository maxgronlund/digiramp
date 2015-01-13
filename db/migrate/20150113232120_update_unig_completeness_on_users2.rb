class UpdateUnigCompletenessOnUsers2 < ActiveRecord::Migration
  def change
    User.find_each do |user|
      user.uniq_completeness = Uniqifyer.uniqify(user.completeness)
      user.save!
    end
  end
end
