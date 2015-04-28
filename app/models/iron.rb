class Iron < ActiveRecord::Base
  
  def test
    #ap ENV["IRON_PROJECT_ID"]
    #ironmq = IronMQ::Client.new(:token => ENV["IRON_TOKEN"], :project_id => "552237b6ee18cf0006000039")
    ##ironmq = IronMQ::Client.new(token: "m2pvEMQ96F1SiqGyxkxpJOCmWKI", project_id: "552237b6ee18cf0006000039")
    #queue = ironmq.queue("digiramp")
    #queue.post("hello world!")
  end
end


