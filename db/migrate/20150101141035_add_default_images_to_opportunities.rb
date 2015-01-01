class AddDefaultImagesToOpportunities < ActiveRecord::Migration
  def change
    count = 0
    Opportunity.find_each do |opportunity|
      begin
        opportunity.image.recreate_versions!
      rescue
        count = 0 if count > 9
        if count < 10
          id = '0' + count.to_s 
        else
          id = count.to_s 
        end
        opportunity.image = File.open(Rails.root.join('app', 'assets', 'images', "opportunities/default_#{id}.jpg"))
        opportunity.image.recreate_versions!
        opportunity.save!
        count += 1
      end
    end

  end
end
