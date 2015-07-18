class UpdatePrivacyOnRecordings < ActiveRecord::Migration
  def change
    Recording.where(privacy: "Only people I invite to my account").update_all(privacy: "Anyone")
    Recording.where(privacy: "Only people I choose").update_all(privacy: "Anyone")
  end
end


#PRIVACY = [ "Anyone", "Only me", "Only people I choose", 'Only people I invite to my account']