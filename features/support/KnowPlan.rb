module KnowPlansHelper

  def find_or_create_plan  name
    return @plan if @plan = plan_with_name( name )
    @plan = FactoryGirl.create(:plan, name: name)
  end
  
  def plan_with_name name
    Plan.find_by(name: name)
  end

  
end

World(KnowPlansHelper)